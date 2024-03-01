import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterName { glutenFree, vegan, vegetarian, lactoseFree }

final Map<FilterName, bool> _defaultFilters = {
  FilterName.glutenFree: false,
  FilterName.vegan: false,
  FilterName.vegetarian: false,
  FilterName.lactoseFree: false,
};

class FiltersNotifier extends StateNotifier<Map<FilterName, bool>> {
  FiltersNotifier() : super(_defaultFilters);

  void toggleFilter(FilterName filterName) {
    switch (filterName) {
      case FilterName.glutenFree:
        state = {...state, FilterName.glutenFree: !state[filterName]!};
        break;
      case FilterName.vegan:
        state = {...state, FilterName.vegan: !state[filterName]!};
        break;
      case FilterName.vegetarian:
        state = {...state, FilterName.vegetarian: !state[filterName]!};
        break;
      case FilterName.lactoseFree:
        state = {...state, FilterName.lactoseFree: !state[filterName]!};
        break;
      default:
        throw Exception('Invalid filterName: $filterName');
    }
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterName, bool>>((ref) {
  return FiltersNotifier();
});
