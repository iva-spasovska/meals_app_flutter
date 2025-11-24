import 'package:flutter/material.dart';
import '../screens/meal_details_page.dart';
import '../screens/category_meals_page.dart';
import '../screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '221032',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/category": (context) => const CategoryMealsPage(),
        "/details": (context) => const MealDetailsPage(),
      },
    );
  }
}
