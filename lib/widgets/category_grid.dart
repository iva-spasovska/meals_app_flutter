import 'package:flutter/material.dart';
import '../models/category.dart';
import 'category_card.dart';

class CategoryGrid extends StatefulWidget {
  final List<Category> category;

  const CategoryGrid({super.key, required this.category});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: widget.category.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: CategoryCard(category: widget.category[index]),
        );
      },
    );
  }
}
