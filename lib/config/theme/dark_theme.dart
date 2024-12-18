import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  textTheme: GoogleFonts.kanitTextTheme(),
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 150, 92)),
  scaffoldBackgroundColor: Colors.black87,
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 34, 150, 92),
    titleTextStyle: GoogleFonts.kanit(
      color: Colors.white,
      fontSize: 20,
    ),
    elevation: 4,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromARGB(255, 34, 150, 92),
    textTheme: ButtonTextTheme.primary,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black54,
    elevation: 4,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade700,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade600),
    ),
  ),
  useMaterial3: true,
);
