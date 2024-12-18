import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  textTheme: GoogleFonts.kanitTextTheme(),
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 150, 92)),
  useMaterial3: true,
);
