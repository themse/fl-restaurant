import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/mock/dummy_data.dart';
import 'package:restaurant/models/category.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/screens/meals.dart';
import 'package:restaurant/providers/favorites_provider.dart';
import 'package:restaurant/widgets/check_mark.dart';
import 'package:restaurant/widgets/meals_list/meal_detail_tile.dart';
import 'package:restaurant/widgets/meals_list/meal_meta_tile.dart';

class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;

  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  void _handleSelectCategory(BuildContext context, Category category) {
    final targetMeals = meals
        .where((element) => element.categoryIds.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(
            title: category.title,
            meals: targetMeals,
          );
        },
      ),
    );
  }

  void _showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Category> targetCategories =
        meal.categoryIds.map((String categoryId) {
      return categories.singleWhere((Category cat) => cat.id == categoryId);
    }).toList();

    final isFavoriteMeal = ref.watch(favoritesProvider).contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                meal.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: ActionChip(
                  onPressed: () {
                    final bool isMealAdded = ref
                        .read(favoritesProvider.notifier)
                        .toggleMealFavoriteStatus(meal: meal);

                    final String message = isMealAdded
                        ? 'Marked as a favorite'
                        : 'Meal is no longer a favorite';

                    _showInfoMessage(context, message);
                  },
                  avatar: Icon(
                    Icons.favorite,
                    color: isFavoriteMeal ? Colors.red : Colors.blueGrey[300],
                  ),
                  label: Text(isFavoriteMeal ? 'Remove' : 'Add'),
                  backgroundColor: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MealMetaTile(
                        label: meal.formattedDuration,
                        icon: Icons.schedule,
                      ),
                      MealMetaTile(
                        label: meal.formattedComplexity,
                        icon: Icons.work,
                      ),
                      MealMetaTile(
                        label: meal.formattedAffordability,
                        icon: Icons.attach_money,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MealDetailTile(
                    title: 'Categories',
                    value: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: targetCategories
                          .map(
                            (category) => GestureDetector(
                              onTap: () =>
                                  _handleSelectCategory(context, category),
                              child: Row(
                                children: [
                                  Text(
                                    category.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: category.color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  MealDetailTile(
                    title: 'Ingredients',
                    value: Text(
                      meal.ingredients.join(', '),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                  MealDetailTile(
                    title: 'Steps',
                    value: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < meal.steps.length; i++)
                          Text(
                            '${i + 1}. ${meal.steps[i]}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                      ],
                    ),
                  ),
                  MealDetailTile(
                    title: 'Gluten Free',
                    value: Container(
                      alignment: Alignment.centerLeft,
                      child: CheckMark(isChecked: meal.isGlutenFree),
                    ),
                  ),
                  MealDetailTile(
                    title: 'Vegan',
                    value: Container(
                      alignment: Alignment.centerLeft,
                      child: CheckMark(isChecked: meal.isVegan),
                    ),
                  ),
                  MealDetailTile(
                    title: 'Vegetarian',
                    value: Container(
                      alignment: Alignment.centerLeft,
                      child: CheckMark(isChecked: meal.isVegetarian),
                    ),
                  ),
                  MealDetailTile(
                    title: 'Lactose Free',
                    value: Container(
                      alignment: Alignment.centerLeft,
                      child: CheckMark(isChecked: meal.isLactoseFree),
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
