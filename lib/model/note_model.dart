import 'package:hive/hive.dart';
part 'note_model.g.dart';

//* using hive for local storing to prevent retrieving from supabase every time
@HiveType(typeId: 0)
class NoteModel extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
   @HiveField(2)
  String content;
   @HiveField(3)
  int colorIndex;
   @HiveField(4)
  DateTime time;
   @HiveField(5)
  String user_id;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.colorIndex,
    required this.time,
    required this.user_id,
  });

  //* Data coming from supabase
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id']?.toString() ?? " ",
      user_id: map['user_id']?.toString() ?? " ",
      title: map['title'] ?? "",
      content: map['content'] ?? "",
      colorIndex: map['color_index'] ?? 0,
      time:
          map['created_at'] != null
              ? DateTime.parse(map['created_at']).toLocal()
              : DateTime.now(),
    );
  }

  //* Data going to database like updating
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user_id': user_id,
      'color_index': colorIndex,
    };
  }
}
