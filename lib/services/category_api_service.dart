import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoryApiService {
  Future<List<Category>> loadCategories() async {
    List<Category> categories = [];

    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List categoryList = data["categories"];

      for (var item in categoryList) {
        categories.add(Category.fromJson(item));
      }
    }

    return categories;
  }
}
