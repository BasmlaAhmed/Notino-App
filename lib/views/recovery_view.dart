import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/widgets/reset_form.dart';

class RecoveryView extends StatefulWidget {
  const RecoveryView({super.key});

  @override
  State<RecoveryView> createState() => _RecoveryViewState();
}

class _RecoveryViewState extends State<RecoveryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          toolbarHeight: 85,
          centerTitle: true,
          title: Text(
            "reset".tr(),
            style: GoogleFonts.nunito(
              fontSize: 30.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          children: [
            Image.asset('assets/images/Forgot password-rafiki.png', width: 250.w),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ResetForm(),
            ),
          ],
        ),
      ),
    );
  }
}
