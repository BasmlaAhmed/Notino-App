import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(255, 33, 33, 33), // canvas
    onPrimary: Colors.black, // color above button
    secondary: Color(0xFF2A2A2A), // hint
    surface: Colors.white, // bg
    error: Colors.redAccent, // delete
    onError: Colors.white, // icon above delete or text
    primaryContainer: Color.fromARGB(255, 181, 181, 181), //alert bg => card
    onPrimaryFixed: Colors.black, // for texts that are unable to appear
  ),
);

final ThemeData dartMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color.fromARGB(255, 33, 33, 33), //canvas
    onPrimary: Colors.black, // color above button
    secondary: Color.fromARGB(255, 106, 106, 106), // hint
    surface: Colors.black, // bg
    error: Colors.redAccent, // delete
    onError: Colors.white, // icon above delete or text
    primaryContainer: Color.fromARGB(255, 33, 33, 33), //alert bg => card
    onPrimaryFixed: Colors.white,  // for texts that are unable to appear
  ),
);
