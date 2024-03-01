import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  bool toggleMealFavoriteStatus({required Meal meal}) {
    final bool isExisting = state.contains(meal);

    if (isExisting) {
      state = state.where((element) => element.id != meal.id).toList();

      return false;
    } else {
      state = [...state, meal];

      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
  return FavoritesNotifier();
});
