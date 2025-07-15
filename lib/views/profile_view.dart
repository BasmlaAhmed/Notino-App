import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/viewmodel/auth_provider.dart';
import 'package:note_app/viewmodel/theme_provider.dart';
import 'package:note_app/widgets/lang_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                onPressed: () async {
                  await authProvider.SignOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                icon: Icon(
                  Icons.logout_outlined,
                  size: 25.w,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: const Color.fromARGB(172, 158, 158, 158),
                child: Icon(
                  Icons.person,
                  size: 100.w,
                  color: const Color.fromARGB(177, 255, 255, 255),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "@${authProvider.username ?? "..."}",
              style: GoogleFonts.nunito(fontSize: 25.sp),
            ),
            Divider(color: Colors.grey, indent: 50, endIndent: 50),
            SizedBox(height: 20.h),
            ListTile(
              onTap: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).toggleTheme();
              },
              leading: Icon(Icons.dark_mode_outlined, size: 25.w),
              title: Text(
                "darkmode".tr(),
                style: GoogleFonts.nunito(fontSize: 20.sp),
              ),
              trailing: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.toggle_off
                    : Icons.toggle_on,
                size: 35.w,
              ),
            ),
            Divider(indent: 20, endIndent: 20, color: Colors.grey),

            ListTile(
              onTap: () {
                LangBottomSheet(context);
              },
              leading: Icon(Icons.language_outlined, size: 25.w),
              title: Text(
                "language".tr(),
                style: GoogleFonts.nunito(fontSize: 20.sp),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 20.w),
            ),
            Divider(indent: 20, endIndent: 20, color: Colors.grey),
            ListTile(
              leading: Icon(Icons.info_outline, size: 25.w),
              title: Text(
                "about".tr(),
                style: GoogleFonts.nunito(fontSize: 20.sp),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 20.w),

              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        "aboutnotino".tr(),
                        style: GoogleFonts.nunito(fontSize: 20.sp),
                      ),
                      content: Text(
                        "notinotext".tr(),
                        style: GoogleFonts.nunito(fontSize: 18.sp),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "close".tr(),
                            style: GoogleFonts.nunito(
                              fontSize: 15.sp,
                              color:
                                  Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(indent: 20, endIndent: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
