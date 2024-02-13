import 'package:flutter/material.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/widgets/meals_list/meal_tile.dart';
import 'package:restaurant/widgets/meals_list/meals_list_empty.dart';

class MealsList extends StatelessWidget {
  final List<Meal> meals;
  final Function({required String mealId}) onTap;

  const MealsList({
    super.key,
    required this.meals,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const MealsListEmpty();
    }

    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: MealTile(
            meal: meals[index],
            onTap: onTap,
          ),
        );
      },
    );
  }
}
