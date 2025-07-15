import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/viewmodel/note_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditNote extends StatefulWidget {
  EditNote({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController newTitleController = TextEditingController();

  TextEditingController newContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    // old data
    newTitleController.text = widget.note.title;
    newContentController.text = widget.note.content;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 85,
        leading: IconButton(
          onPressed: () async {
            // if there is no changes just hit back
            final currentTitle = newTitleController.text;
            final currentContent = newContentController.text;

            final isChanged =
                currentTitle != widget.note.title ||
                currentContent != widget.note.content;
            if (!isChanged) {
              Navigator.pop(context);
              return;
            }

            // if there is any change ask first
            bool willDiscard = await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    icon: Icon(
                      Icons.info,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 40,
                    ),
                    content: Text(
                      "surediscard".tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    actions: [
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            "no".tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text(
                            "discard".tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            );
            if (willDiscard == true) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("discarded".tr())));
              Navigator.pop(context);
            }
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
              onPressed: () async {
                {
                  final currentTitle = newTitleController.text;
                  final currentContent = newContentController.text;

                  final isChanged =
                      currentTitle != widget.note.title ||
                      currentContent != widget.note.content;
                  if (!isChanged) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("nochanges".tr())));
                    return;
                  }
                  bool willSave = await showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          icon: Icon(
                            Icons.info,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 40.w,
                          ),
                          content: Text(
                            "savechanges".tr(),
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          actions: [
                            Wrap(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(
                                      "discard".tr(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onError,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w,),
                                Container(
                                  width: 100.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      56,
                                      255,
                                      169,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text(
                                      "save".tr(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onError,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  );
                  if (willSave == true) {
                    noteProvider.updateNote(
                      widget.note.id,
                      newTitleController.text,
                      newContentController.text,
                    );
                    widget.note.title = newTitleController.text;
                    widget.note.content = newContentController.text;

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("noteupdated".tr())));
                  }
                  Navigator.pop(context, widget.note);
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
                controller: newTitleController,
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
                  controller: newContentController,
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
    );
  }
}
