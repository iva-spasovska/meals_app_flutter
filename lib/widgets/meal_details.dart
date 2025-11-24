import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;

  const MealDetails({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(meal.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              meal.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          Divider(color: Colors.grey.shade900),
          Text(
            "Ingredients:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...meal.ingredients.entries.map((entry) {
            return Text(
              "• ${entry.key} - ${entry.value}",
              style: TextStyle(fontSize: 14),
            );
          }),
          SizedBox(height: 20),
          Text(
            "Instructions:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(meal.instructions, style: TextStyle(fontSize: 14)),
          SizedBox(height: 20),
          if (meal.link != null && meal.link!.isNotEmpty)
            Text(
              "YouTube Tutorial:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          Text(
            "${meal.link}",
            style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
