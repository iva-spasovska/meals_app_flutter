import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealApiService {
  Future<List<Meal>> loadMealsByCategory({required String category}) async {
    List<Meal> meals = [];

    final response = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List mealList = data["meals"];

      for (var meal in mealList) {
        final id = meal["idMeal"];
        final fullMeal = await getMealById(id);

        if (fullMeal != null) {
          meals.add(fullMeal);
        }
      }
    }
    return meals;
  }

  Future<Meal?> getMealById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["meals"] != null && data["meals"].isNotEmpty) {
          return Meal.fromJson(data["meals"][0]);
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Meal?> getRandomMeal() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["meals"] != null && data["meals"].isNotEmpty) {
          return Meal.fromJson(data["meals"][0]);
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
