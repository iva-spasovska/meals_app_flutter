import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<Meal> meals;
  final List<String> favoriteIds;
  final Function(Meal) onToggleFavorite;

  const MealGrid({
    super.key,
    required this.meals,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 50 / 60,
      ),
      itemCount: meals.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final meal = meals[index];
        final isFav = favoriteIds.contains(meal.id);
        return MealCard(
          meal: meal,
          isFavorite: isFav,
          onToggleFavorite: () => onToggleFavorite(meal),
        );
      },
    );
  }
}
