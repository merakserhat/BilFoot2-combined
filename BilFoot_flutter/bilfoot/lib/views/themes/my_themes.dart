import 'package:bilfoot/config/constants/program_colors.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme:
        getTextTheme(textColor: Colors.yellow, buttonColor: Colors.white),
    fontFamily: "Poppins",

    /*scaffoldBackgroundColor: ProgramColors.gloneraDarkBackground,
    fontFamily: "Poppins",
    primaryColor: ProgramColors.gloneraDarkMainGray,
    colorScheme: ColorScheme.dark(
        primary: ProgramColors.gloneraDarkMainGray,
        secondary: Colors.white70,
        onBackground: ProgramColors.gloneraDarkMainGray),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(ProgramColors.gloneraDarkMainGray),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
      ),
    ),
    textButtonTheme:
    TextButtonThemeData(style: TextButton.styleFrom(primary: Colors.white)),
    textTheme: getTextTheme(textColor: Colors.white, buttonColor: Colors.white),
    toggleButtonsTheme: ToggleButtonsThemeData(
        selectedColor: Color(0xFF747474),
        color: ProgramColors.gloneraDarkMainGray,
        disabledColor: Colors.white),
    snackBarTheme:
    SnackBarThemeData(backgroundColor: ProgramColors.gloneraDarkMainGray),*/
  );

  static final lightTheme = ThemeData(
    textTheme: getTextTheme(
      textColor: Colors.black87,
      buttonColor: Colors.white,
    ),
    fontFamily: "Poppins",
    primaryColor: ProgramColors.bilkentPalette[1],
    colorScheme: ColorScheme.light(
      primary: ProgramColors.bilkentPalette[1],
      secondary: ProgramColors.bilkentPalette[0],
      onBackground: ProgramColors.bilkentPalette[4],
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
          elevation: MaterialStateProperty.all(0),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: "Poppins",
            ),
          )),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
    ),
    /*scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    primaryColor: ProgramColors.gloneraMainGreen,

    iconTheme: IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(ProgramColors.gloneraMainGreen),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: "Poppins",
            ),
          )),
    ),
    textTheme: getTextTheme(
        textColor: ProgramColors.gloneraDarkMainGray,
        buttonColor: Colors.white),
    toggleButtonsTheme: ToggleButtonsThemeData(
        color: Colors.white,
        selectedColor: ProgramColors.gloneraMainGreen,
        disabledColor: ProgramColors.gloneraMainGreen),*/
  );

  static TextTheme getTextTheme(
      {required Color textColor, required Color buttonColor}) {
    return TextTheme(
      headline1: TextStyle(
          color: textColor, fontWeight: FontWeight.w500, fontSize: 18),
      headline2: TextStyle(
          color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
      headline3: TextStyle(
          color: textColor, fontWeight: FontWeight.w500, fontSize: 16),
      headline4: TextStyle(
          color: textColor, fontWeight: FontWeight.w600, fontSize: 14),
      headline5: TextStyle(
          color: textColor, fontWeight: FontWeight.w500, fontSize: 14),
      headline6: TextStyle(
          color: textColor, fontWeight: FontWeight.w500, fontSize: 12),
      bodyText1: TextStyle(
          color: textColor, fontWeight: FontWeight.w400, fontSize: 12),
      bodyText2: TextStyle(
          color: textColor, fontWeight: FontWeight.normal, fontSize: 14),
      button: TextStyle(
          color: buttonColor, fontWeight: FontWeight.w500, fontSize: 12),
      overline: TextStyle(
          color: textColor,
          fontWeight: FontWeight.normal,
          fontSize: 9,
          letterSpacing: 0.1),
    );
  }
}
