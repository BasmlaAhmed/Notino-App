import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/utils/note_colors.dart';
import 'package:intl/intl.dart';
import 'package:note_app/views/note_details.dart';

class NoteCard extends StatelessWidget {
  NoteCard({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: NoteColors.getColor(note.colorIndex),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      NoteDetails(note: note),
            ),
          );
        },
        child: ListTile(
          title:
              note.title.trim().isNotEmpty
                  ? Hero(
                    tag: "noteTitle-${note.id}",
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        note.title,
                        style: GoogleFonts.nunito(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  )
                  : Text(
                    note.content.split('\n').first, // 1st line
                    style: GoogleFonts.nunito(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                note.time != null
                    ? DateFormat(
                      "MMM d, y",
                      context.locale.languageCode,
                    ).format(note.time)
                    : "",

                style: GoogleFonts.nunito(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
