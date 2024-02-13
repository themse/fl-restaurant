import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/mock/dummy_data.dart';
import 'package:restaurant/screens/categories.dart';
import 'package:restaurant/screens/meals.dart';

final theme = ThemeData.from(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: MealsScreen(title: 'Meals overview', meals: meals),
      // home: const CategoriesScreen(),
    );
  }
}
