import 'package:flutter/material.dart';

const Color blue = Color(0xFF1D4ED8);
const Color starOn = Color(0xFFF5B301);
const Color starOff = Color(0xFFCFD5E3);
const Color ink = Color(0xFF14213D);
const Color muted = Color(0xFF5B6784);
const Color line = Color(0xFFD5DBE8);
const Color pageBg = Color(0xFFF5F7FB);
const Color danger = Color(0xFFB42318);

final BorderRadius corner = BorderRadius.circular(4);
final RoundedRectangleBorder boxShape = RoundedRectangleBorder(borderRadius: corner);

ThemeData buildTheme() {
  OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
        borderRadius: corner,
        borderSide: BorderSide(color: color, width: width),
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: blue, primary: blue),
    scaffoldBackgroundColor: pageBg,
    fontFamily: 'Segoe UI',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: border(line, 1),
      enabledBorder: border(line, 1),
      focusedBorder: border(blue, 2),
      errorBorder: border(danger, 1),
      focusedErrorBorder: border(danger, 2),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: blue,
        side: const BorderSide(color: blue),
        shape: boxShape,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        shape: boxShape,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  );
}
