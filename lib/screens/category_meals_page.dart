import 'package:flutter/material.dart';
import 'package:lab2/screens/favorites_page.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';
import '../widgets/meal_card.dart';
import '../widgets/random_meal_button.dart';

List<String> favoriteMealIds = [];
List<Meal> allMeals = [];

class CategoryMealsPage extends StatefulWidget {
  const CategoryMealsPage({super.key});

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  late Category category;
  final MealApiService _mealService = MealApiService();

  List<Meal> _meals = [];
  List<Meal> _filteredMeals = [];

  bool _isLoading = true;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    category = ModalRoute.of(context)!.settings.arguments as Category;
    _loadMeals(category.name);
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (favoriteMealIds.contains(meal.id)) {
        favoriteMealIds.remove(meal.id);
      } else {
        favoriteMealIds.add(meal.id);
      }
    });
  }

  void _filterMeals(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredMeals = _meals;
      } else {
        _filteredMeals = _meals
            .where(
              (meal) => meal.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  Future<void> _loadMeals(String categoryName) async {
    final meals = await _mealService.loadMealsByCategory(
      category: categoryName,
    );
    if (!mounted) return;
    setState(() {
      _meals = meals;
      _filteredMeals = meals;
      for (var meal in meals) {
        if (!allMeals.any((m) => m.id == meal.id)) {
          allMeals.add(meal);
        }
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFA10707),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
          RandomMealButton(),
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search meals...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      _filterMeals(value);
                    },
                  ),
                ),
                Expanded(
                  child: _filteredMeals.isEmpty && _searchQuery.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No meals found",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: GridView.builder(
                            itemCount: _filteredMeals.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 200 / 244,
                                ),
                            itemBuilder: (ctx, index) {
                              final meal = _filteredMeals[index];
                              final isFav = favoriteMealIds.contains(meal.id);
                              return MealCard(
                                meal: meal,
                                isFavorite: isFav,
                                onToggleFavorite: () => _toggleFavorite(meal),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
