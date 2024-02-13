import 'package:flutter/material.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/screens/meal_details.dart';
import 'package:restaurant/widgets/meals_list/meals_list.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;

  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
  });

  void handleSelectMeal({required BuildContext context, required Meal meal}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(
                title!,
              ),
            )
          : null,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: MealsList(
          meals: meals,
          onTap: ({required meal}) =>
              handleSelectMeal(context: context, meal: meal),
        ),
      ),
    );
  }
}
