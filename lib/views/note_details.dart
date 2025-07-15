import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/views/edit_note.dart';

class NoteDetails extends StatefulWidget {
  NoteDetails({super.key, required this.note});

  final NoteModel note;

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late NoteModel currentNote; 
  @override
  void initState() {
    super.initState();
    currentNote = widget.note;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 85,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 28.w,
            ),
          ),
        actions: [
          Container(
            width: 43,
            height: 45,
            margin: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditNote(note: currentNote),
                  ),
                );
                if (result != null && result is NoteModel) {
                  setState(() {});
                }
              },
              icon: Icon(Icons.edit, color: Colors.white, size: 23.w),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "noteTitle-${currentNote.id}",
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    widget.note.title,
                    style: GoogleFonts.nunito(
                      fontSize: 35.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                currentNote.content,
                style: GoogleFonts.nunito(
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        DateFormat.jm(context.locale.languageCode).format(widget.note.time), //* time formate
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        DateFormat("MMM d, y", context.locale.languageCode).format(widget.note.time),
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
