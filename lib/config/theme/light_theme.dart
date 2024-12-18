import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.kanitTextTheme(),
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 150, 92)),
  scaffoldBackgroundColor: Colors.white,
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
    shadowColor: Colors.grey.shade300,
    elevation: 2,
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: Colors.grey.shade100,
  //   border: OutlineInputBorder(
  //     borderSide: BorderSide(color: Colors.grey.shade300),
  //   ),
  // ),
  useMaterial3: true,
);
