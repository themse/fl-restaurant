import 'package:flutter/material.dart';
import 'package:restaurant/mock/dummy_data.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/screens/categories.dart';
import 'package:restaurant/screens/filters.dart';
import 'package:restaurant/screens/meals.dart';
import 'package:restaurant/widgets/main_drawer.dart';

typedef ScreenTitle = String;

class TabConfig {
  final String title;
  final Widget screen;

  TabConfig({required this.title, required this.screen});
}

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  late List<TabConfig> _screens;

  final List<Meal> _favoriteMeals = [];

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

  void _toggleMealFavoriteStatus({required Meal meal}) {
    final bool isExisting = _favoriteMeals.contains(meal);

    setState(() {
      if (isExisting) {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favorite');
      } else {
        setState(() {
          _favoriteMeals.add(meal);
          _showInfoMessage('Marked as a favorite');
        });
      }
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
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
          onToggleFavorite: _toggleMealFavoriteStatus,
        ),
      ),
      TabConfig(
        title: 'Favorites',
        screen: MealsScreen(
          meals: _favoriteMeals,
          onToggleFavorite: _toggleMealFavoriteStatus,
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
