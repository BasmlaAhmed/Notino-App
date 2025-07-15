import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:note_app/viewmodel/auth_provider.dart';
import 'package:note_app/views/home_view.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword1 = true;
  bool hiddenPassword2 = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

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
                controller: usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "userempty".tr();
                  }
                  if (value.length < 2) {
                    return 'userlength'.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "@username",
                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                  labelText: "username".tr(),
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
              SizedBox(height: 25.h),
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
              SizedBox(height: 25.h),
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
                obscureText: hiddenPassword1,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hiddenPassword1 = !hiddenPassword1;
                      });
                    },
                    icon: Icon(
                      hiddenPassword1 ? Icons.visibility_off : Icons.visibility,
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
              SizedBox(height: 25.h),
              TextFormField(
                controller: confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "passwordempty".tr();
                  }
                  if (value.length < 8) {
                    return 'passwordlength'.tr();
                  }
                  return null;
                },
                obscureText: hiddenPassword2,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hiddenPassword2 = !hiddenPassword2;
                      });
                    },
                    icon: Icon(
                      hiddenPassword2 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  hintText: "***********",
                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "confirmpass".tr(),
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
              SizedBox(height: 15.h),
              InkWell(
                onTap: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      await _authProvider.signUp(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        usernameController.text.trim(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    }
                    passwordController.clear();
                    confirmPasswordController.clear();
                  } on AuthException catch (e) {
                    //* specific error
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.message.tr())));
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${"signupfailed".tr()} ${error.toString()}",
                        ),
                      ),
                    );
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
                        "create".tr(),
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
