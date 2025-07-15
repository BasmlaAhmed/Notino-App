import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:note_app/viewmodel/auth_provider.dart';
import 'package:note_app/views/home_view.dart';
import 'package:note_app/views/recovery_view.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
              SizedBox(height: 30.h),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "passwordempty".tr();
                  }
                  if (value.length < 8) {
                    return 'passwordlength'.tr();
                  }
                  return null;
                },
                obscureText: hiddenPassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hiddenPassword = !hiddenPassword;
                      });
                    },
                    icon: Icon(
                      hiddenPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  hintText: "***********",
                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "password".tr(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecoveryView()),
                      );
                    },
                    child: Text(
                      "forgot".tr(),
                      style: GoogleFonts.nunito(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      await _authProvider.Login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    }
                    passwordController.clear();
                    emailController.clear();
                  } on AuthException catch (e) {
                    //* specific error
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.message).tr()));
                  } catch (error) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("loginfail".tr())));
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
                        "login".tr(),
                        style: GoogleFonts.nunito(fontSize: 20.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
