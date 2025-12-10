import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'category_meals_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void _toggleFavorite(Meal meal) {
    setState(() {
      if (favoriteMealIds.contains(meal.id)) {
        favoriteMealIds.remove(meal.id);
      } else {
        favoriteMealIds.add(meal.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = allMeals
        .where((meal) => favoriteMealIds.contains(meal.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Favorites",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFA10707),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade200,
      body: favoriteMeals.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 200 / 244,
              ),
              itemCount: favoriteMeals.length,
              itemBuilder: (context, index) {
                final meal = favoriteMeals[index];
                return MealCard(
                  meal: meal,
                  isFavorite: favoriteMealIds.contains(meal.id),
                  onToggleFavorite: () {
                    _toggleFavorite(meal);
                  },
                );
              },
            ),
    );
  }
}
