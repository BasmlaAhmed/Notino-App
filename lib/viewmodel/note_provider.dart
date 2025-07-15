import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/utils/note_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> notes = [];
  int noteID = 1;
  final supabase = Supabase.instance.client;

  Future<void> fetchNotes() async {
    final userID = supabase.auth.currentUser?.id;
    if (userID == null) return;
    final response = await supabase
        .from('notes')
        .select()
        .eq("user_id", userID)
        .order("created_at", ascending: false);
    notes =
        (response as List<dynamic>).map((e) => NoteModel.fromMap(e)).toList();
    final box = Hive.box("notesBox");
    await box.put("notes", notes);
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    final userID = supabase.auth.currentUser?.id;
    if (userID == null) return;
    try {
      final response =
          await supabase.from('notes').insert({
            'title': title,
            'content': content,
            'user_id': userID,
            'color_index': NoteColors.getColorIndex(),
          }).select();
      if (response != null && response.isNotEmpty) {
        notes.insert(0, NoteModel.fromMap(response[0]));
        final box = Hive.box("notesBox");
        box.put("notes", notes);
        notifyListeners();
      }
    } catch (e) {
      return log(e.toString());
    }
  }

  Future<void> updateNote(String id, String newTitle, String newContent) async {
    try {
      await supabase
          .from('notes')
          .update(({'title': newTitle, 'content': newContent}))
          .eq('id', id);

      final int index = notes.indexWhere((note) => note.id == id);
      if (index != -1) {
        notes[index].title = newTitle;
        notes[index].content = newContent;
        notifyListeners();
      }
      final box = Hive.box("notesBox");
      box.put("notes", notes);
    } on AuthException catch (e) {
      return log(e.toString());
    } catch (e) {
      return log(e.toString());
    }
  }

  Future<void> removeNote(String id) async {
    await supabase.from('notes').delete().eq('id', id);
    notes.removeWhere((note) => note.id == id);
    final box = Hive.box("notesBox");
    box.put("notes", notes);

    notifyListeners();
  }

  Future<void> loadFromcache() async {
    final box = Hive.box("notesBox");
    final cachedNotes = box.get("notes") ?? [];
    notes = List<NoteModel>.from(cachedNotes);
    notifyListeners();
  }
}
