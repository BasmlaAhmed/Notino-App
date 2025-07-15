import 'dart:math';

import 'package:flutter/widgets.dart';

class NoteColors {
   static List pastelColors = [
    Color.fromARGB(255, 254, 179, 214),
    Color.fromARGB(255, 190, 221, 250),
    Color.fromARGB(255, 195, 255, 195),
    Color.fromARGB(255, 254, 236, 172),
    Color.fromARGB(255, 209, 178, 253),
    Color.fromARGB(255, 255, 150, 161),
  ];

  //* generate random colors for every note by their index
  //* used when generating the note
  static int getColorIndex() {
    final Random random = Random();
    return random.nextInt(pastelColors.length);
  }

  //* display the color from the first method 
  //* used when displaying the note (UI)
  static Color getColor(int index){
    return pastelColors[index];
  }
}
