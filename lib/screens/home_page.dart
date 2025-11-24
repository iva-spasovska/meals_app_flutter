import 'package:flutter/material.dart';
import 'package:lab2/services/meal_api_service.dart';
import '../models/category.dart';
import '../services/category_api_service.dart';
import '../widgets/category_grid.dart';
import '../widgets/random_meal_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoryApiService _apiService = CategoryApiService();
  late final List<Category> _categories;
  List<Category> _filteredCategories = [];

  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recipe Categories",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFA10707),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          RandomMealButton(),
        ],
      ),
      backgroundColor: Colors.grey.shade200,

      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search categories...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      _filterCategories(value);
                    },
                  ),
                ),
                Expanded(
                  child: _filteredCategories.isEmpty && _searchQuery.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey.shade700,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No category found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: CategoryGrid(category: _filteredCategories),
                        ),
                ),
              ],
            ),
    );
  }

  Future<void> _loadCategories() async {
    final list = await _apiService.loadCategories();

    setState(() {
      _categories = list;
      _filteredCategories = list;
      _isLoading = false;
    });
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where(
              (category) =>
                  category.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }
}
