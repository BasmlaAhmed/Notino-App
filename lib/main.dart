import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/utils/app_theme.dart';
import 'package:note_app/viewmodel/auth_provider.dart';
import 'package:note_app/viewmodel/note_provider.dart';
import 'package:note_app/viewmodel/theme_provider.dart';
import 'package:note_app/views/home_view.dart';
import 'package:note_app/views/login_view.dart';
import 'package:note_app/views/sign_up_view.dart';
import 'package:note_app/views/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox('notesBox');

  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: 'https://llqyvfjtabfdcblwnuqi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxscXl2Zmp0YWJmZGNibHdudXFpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE1NTE0NTksImV4cCI6MjA2NzEyNzQ1OX0.gD9O-jjYuaxX9uWSeHmOfmsOnE8b9KJVxLW44lqNXQo',
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          theme: lightMode,
          darkTheme: dartMode,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => SplashView(),
            '/login': (context) => LoginView(),
            '/signup': (context) => SignUpView(),
            '/home': (context) => HomeView(),
          },
          localizationsDelegates:
              context
                  .localizationDelegates, //* using easy localization for translations
          supportedLocales:
              context.supportedLocales, //* supported langs => en , ar
          locale:
              context.locale, //* use what lang the user chosen or default lang
        );
      },
    );
  }
}
