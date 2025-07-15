import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/viewmodel/auth_provider.dart';
import 'package:note_app/viewmodel/note_provider.dart';
import 'package:note_app/views/error_view.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> _navigate() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    await Future.delayed(Duration(seconds: 3));
    try {
      await authProvider.checkSession();

      final checkConnection = await Connectivity().checkConnectivity();
      final hasInternet = checkConnection != ConnectivityResult.none;

      if (authProvider.isLogged) {
        if (hasInternet) {
          //* if there's internet and user is logged in
          await noteProvider.fetchNotes();
        } else {
          //* if there's no internet but user is logged in
          await noteProvider.loadFromcache();
        }
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        //* if user is not logged in
        Navigator.pushReplacementNamed(context, '/login');
      }
      await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      log(e.toString());
      print("Error while loading splash $e");
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ErrorView()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(
                  'assets/animations/Animation - 1751739249932.json',
                ),
              ),
              TweenAnimationBuilder(
                duration: Duration(seconds: 1),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Text(
                      "notino".tr(),
                      style: GoogleFonts.nunito(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.lerp(
                          const Color.fromARGB(255, 191, 25, 116),
                          const Color.fromARGB(255, 171, 39, 176),
                          value,
                        ),
                      ),
                    ),
                  );
                },
              ),

              TweenAnimationBuilder(
                duration: Duration(seconds: 1),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Text(
                      "slogan".tr(),
                      style: GoogleFonts.nunito(
                        fontSize: 18.sp,
                        color: Color.lerp(
                          const Color.fromARGB(255, 191, 25, 116),
                          const Color.fromARGB(255, 171, 39, 176),
                          value,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
