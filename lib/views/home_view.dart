import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/viewmodel/note_provider.dart';
import 'package:note_app/views/add_to_note_view.dart';
import 'package:note_app/views/profile_view.dart';
import 'package:note_app/widgets/note_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 85,
        title: Text(
          "notino".tr(),
          style: GoogleFonts.nunito(
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
          ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileView()),
                );
              },
              icon: Icon(Icons.person, color: Colors.white, size: 27.w),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  noteProvider.notes.isEmpty
                      ? Column(
                        children: [
                          Image.asset("assets/images/nonote.png"),
                          Text(
                            "createnote".tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      )
                      : ListView.builder(
                        itemCount: noteProvider.notes.length,
                        itemBuilder: (context, index) {
                          final note = noteProvider.notes[index];
                          return Dismissible(
                            background: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.onError,
                                size: 50,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            key: Key(note.id.toString()),
                            child: NoteCard(note: note),
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      backgroundColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                      icon: Icon(
                                        Icons.info,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                        size: 40,
                                      ),
                                      content: Text(
                                        "delete".tr(),
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      actions: [
                                        Container(
                                          width: 120,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(
                                              "no".tr(),
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
                                        Container(
                                          width: 120,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.error,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text(
                                              "yes".tr(),
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
                                      elevation: 20,
                                    ),
                              );
                            },
                            onDismissed: (direction) {
                              noteProvider.removeNote(note.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("noteremoved".tr())),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddToNoteView()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 30.w),
      ),
    );
  }
}
