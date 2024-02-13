import 'package:flutter/material.dart';
import 'package:restaurant/mock/dummy_data.dart';
import 'package:restaurant/models/category.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/screens/meals.dart';
import 'package:restaurant/widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _handleSelectCategory(
      {required BuildContext context, required String categoryId}) {
    final Category currentCategory =
        categories.singleWhere((element) => element.id == categoryId);

    final List<Meal> currentMeals = meals
        .where((element) => element.categoryIds.contains(categoryId))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen(title: currentCategory.title, meals: currentMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals Categories'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return CategoryTile(
              category: categories[index],
              onTapCategory: ({required categoryId}) {
                _handleSelectCategory(context: context, categoryId: categoryId);
              },
            );
          },
        ),
      ),
    );
  }
}
