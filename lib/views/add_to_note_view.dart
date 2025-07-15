import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/viewmodel/note_provider.dart';
import 'package:provider/provider.dart';

class AddToNoteView extends StatelessWidget {
  AddToNoteView({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          toolbarHeight: 85,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 28.w),
          ),

          actions: [
            Container(
              margin: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {
                  if (contentController.text.isNotEmpty || titleController.text.isNotEmpty) {
                    noteProvider.addNote(
                      titleController.text,
                      contentController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.save, size: 25.w, color: Colors.white),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  maxLines: null,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  cursorHeight: 45,
                  style: TextStyle(fontSize: 35.sp),
                  controller: titleController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: "title".tr(),
                    hintStyle: TextStyle(
                      fontSize: 30.sp,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    cursorHeight: 30,
                    style: TextStyle(fontSize: 22.sp),
                    controller: contentController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      hintText: "type".tr(),
                      hintStyle: TextStyle(
                        fontSize: 18.sp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
