import 'package:flutter/material.dart';

import '/app/ui/styles/colors_app.dart';

class ThemeConfig {
  ThemeConfig._();

  static final theme = ThemeData(
    scaffoldBackgroundColor: ColorsApp.backgroundColor,
    fontFamily: 'Poppins',
    primaryColor: ColorsApp.elementColor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: ColorsApp.darkBackgroundColor,
    primaryColor: ColorsApp.darkElementColor,
  );
}
