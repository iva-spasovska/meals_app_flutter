import 'package:flutter/material.dart';
import '../services/meal_api_service.dart';

class RandomMealButton extends StatelessWidget {
  final MealApiService _api = MealApiService();

  RandomMealButton({super.key});

  Future<void> _openRandomMeal(BuildContext context) async {
    final meal = await _api.getRandomMeal();
    if (meal == null) return;

    Navigator.pushNamed(context, "/details", arguments: meal);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openRandomMeal(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: const Text(
          "Random Meal",
          style: TextStyle(
            color: Color(0xFFA10707),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
