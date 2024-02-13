import 'package:flutter/material.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/widgets/meals_list/meal_detail_tile.dart';

class MealTile extends StatelessWidget {
  final Meal meal;
  final Function({required String mealId}) onTap;

  const MealTile({super.key, required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTap(mealId: meal.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 15),
                    MealDetailTile(
                      title: 'Duration',
                      value: meal.duration.toString(),
                    ),
                    const SizedBox(height: 15),
                    MealDetailTile(
                      title: 'Complexity',
                      value: meal.complexity.name.toUpperCase(),
                    ),
                    const SizedBox(height: 15),
                    MealDetailTile(
                      title: 'Affordability',
                      value: meal.affordability.name.toUpperCase(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
