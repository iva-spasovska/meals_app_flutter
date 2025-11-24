class Meal {
  String id;
  String name;
  String image;
  String instructions;
  String? link;
  Map<String, String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    this.link,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    Map<String, String> ingredientsMap = {};

    for (int i = 1; i <= 20; i++) {
      final ingredient = json["strIngredient$i"];
      final measure = json["strMeasure$i"];

      if (ingredient != null &&
          ingredient.toString().isNotEmpty &&
          ingredient.toString() != "") {
        ingredientsMap[ingredient] = measure ?? "";
      }
    }

    return Meal(
      id: json["idMeal"],
      name: json["strMeal"],
      image: json["strMealThumb"],
      instructions: json["strInstructions"],
      link: json["strYoutube"],
      ingredients: ingredientsMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': image,
      'strInstructions': instructions,
      'strYoutube': link,
      'ingredients': ingredients,
    };
  }
}
