import 'package:flutter/material.dart';
import 'package:restaurant/mock/dummy_data.dart';
import 'package:restaurant/models/category.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/screens/meals.dart';
import 'package:restaurant/widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function({required Meal meal}) onToggleFavorite;

  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
  });

  void _handleSelectCategory(
      {required BuildContext context, required Category category}) {
    final List<Meal> filteredMeals = meals
        .where((element) => element.categoryIds.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 3 / 2, // height
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return CategoryTile(
              category: category,
              onTapCategory: () {
                _handleSelectCategory(context: context, category: category);
              },
            );
          },
        ),
      ),
    );
  }
}
