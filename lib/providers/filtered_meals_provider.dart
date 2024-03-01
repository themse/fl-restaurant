import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/models/meal.dart';
import 'package:restaurant/providers/meals_provider.dart';
import 'package:restaurant/providers/filters_provider.dart';

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);

  final filteredMeal = meals.where((meal) {
    if (selectedFilters[FilterName.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilters[FilterName.vegan]! && !meal.isVegan) {
      return false;
    }
    if (selectedFilters[FilterName.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (selectedFilters[FilterName.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    return true;
  }).toList();

  return filteredMeal;
});
