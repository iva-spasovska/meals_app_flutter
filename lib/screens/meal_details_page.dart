import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_details.dart';

class MealDetailsPage extends StatelessWidget {
  const MealDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recipe",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFA10707),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade200,
      body: MealDetails(meal: meal),
    );
  }
}
