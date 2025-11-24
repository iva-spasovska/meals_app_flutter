import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'meal_card.dart';

class MealGrid extends StatefulWidget {
  final List<Meal> meal;

  const MealGrid({super.key, required this.meal});

  @override
  State<MealGrid> createState() => _MealGridState();
}

class _MealGridState extends State<MealGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 50 / 60,
      ),
      itemCount: widget.meal.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MealCard(meal: widget.meal[index]);
      },
    );
  }
}
