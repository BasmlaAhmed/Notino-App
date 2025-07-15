import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:note_app/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetForm extends StatefulWidget {
  const ResetForm({super.key});

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return "emailempty".tr();
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'emailshouldhave'.tr();
              }
              if (value.contains(RegExp(r'[!#\$%^&*(),?":{}|<>]')) ||
                  value.contains(" ")) {
                return 'illegal'.tr();
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "example@example.com",
              hintStyle: GoogleFonts.nunito(color: Colors.grey),
              floatingLabelBehavior: FloatingLabelBehavior.always,

              labelText: "email".tr(),
              labelStyle: GoogleFonts.nunito(
                fontSize: 21.sp,
                color: Theme.of(context).colorScheme.onPrimaryFixed,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color.fromARGB(131, 158, 158, 158),
                ),
              ),
              focusedBorder: GradientOutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                width: 2.w,
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    const Color.fromARGB(255, 209, 39, 181),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.all(18),
            ),
          ),
        ),
        SizedBox(height: 30.h),
        InkWell(
          onTap: () async {
            try {
              if (_formKey.currentState!.validate()) {
                await _authProvider.resetPassword(emailController.text.trim());
                setState(() {
                  sent = true;
                });
              }
              if (sent) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "checkyouremail".tr(),
                      style: GoogleFonts.nunito(fontSize: 15.sp),
                    ),
                  ),
                );
              }
            } on AuthException catch (e) {
              //* specific error
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(e.message.tr())));
            } catch (error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("emailnotvalid".tr())));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    const Color.fromARGB(255, 209, 39, 181),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "sendlink".tr(),
                  style: GoogleFonts.nunito(fontSize: 20.sp),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
