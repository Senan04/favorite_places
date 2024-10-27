import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

// final colorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.light,
//   seedColor: const Color.fromARGB(255, 37, 126, 243),
//   surface: const Color.fromARGB(255, 15, 101, 151),
// );

// final theme = ThemeData(
//   colorScheme: ColorScheme.fromSeed(
//     brightness: Brightness.dark,
//     seedColor: const Color.fromARGB(255, 182, 255, 47),
//   ),
//   scaffoldBackgroundColor: const Color.fromARGB(255, 2, 44, 44),
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//     backgroundColor: Color.fromARGB(255, 17, 121, 121),
//   ),
//   textTheme: GoogleFonts.latoTextTheme().apply(bodyColor: Colors.white),
// );

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 1, 31, 26),
);

final theme = ThemeData().copyWith(
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.surface,
  textTheme: GoogleFonts.latoTextTheme().apply(bodyColor: Colors.white),
);

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Places',
      theme: theme,
      home: const Places(),
    );
  }
}
