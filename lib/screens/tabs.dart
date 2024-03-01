import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/widgets/main_drawer.dart';
import 'package:restaurant/providers/meals_provider.dart';
import 'package:restaurant/providers/favorites_provider.dart';
import 'package:restaurant/screens/categories.dart';
import 'package:restaurant/screens/filters.dart';
import 'package:restaurant/screens/meals.dart';

typedef ScreenTitle = String;

class TabConfig {
  final String title;
  final Widget screen;

  TabConfig({required this.title, required this.screen});
}

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  late List<TabConfig> _screens;

  Map<FilterName, bool> _selectedFilters = {
    FilterName.glutenFree: false,
    FilterName.vegan: false,
    FilterName.vegetarian: false,
    FilterName.lactoseFree: false,
  };

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    switch (identifier) {
      case 'meals':
        // Logic
        break;

      case 'filters':
        final result = await Navigator.of(context).push<Map<FilterName, bool>>(
          MaterialPageRoute(
            builder: (context) => FiltersScreen(
              currentFilters: _selectedFilters,
            ),
          ),
        );

        if (!mounted) return;

        if (result != null) {
          setState(() {
            _selectedFilters = result;
          });
        }

        break;

      default:
        throw Exception('Invalid identifier: $identifier');
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoritesProvider);
    final meals = ref.watch(mealsProvider);
    // apply filters
    final filteredMeal = meals.where((meal) {
      if (_selectedFilters[FilterName.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[FilterName.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[FilterName.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[FilterName.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }

      return true;
    }).toList();

    // init screens
    _screens = [
      TabConfig(
        title: 'Meals Categories',
        screen: CategoriesScreen(
          availableMeals: filteredMeal,
        ),
      ),
      TabConfig(
        title: 'Favorites',
        screen: MealsScreen(
          meals: favoriteMeals,
        ),
      ),
    ];
    final TabConfig activeTabConfig = _screens[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTabConfig.title),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activeTabConfig.screen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
