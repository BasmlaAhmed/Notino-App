import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void LangBottomSheet(BuildContext context) {
  Locale currentLocale = context.locale;

  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    elevation: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                currentLocale.languageCode == "en"
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked_rounded,
                color: Colors.blue,
              ),
              title: Text(
                "English",
                style: GoogleFonts.nunito(fontSize: 20.sp),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString("lang", "en");
                await context.setLocale(const Locale("en"));
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                currentLocale.languageCode == "ar"
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked_rounded,
                color: Colors.blue,
              ),
              title: Text(
                "العربية",
                style: GoogleFonts.nunito(fontSize: 20.sp),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString("lang", "ar");
                await context.setLocale(const Locale("ar"));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
