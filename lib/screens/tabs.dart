import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/widgets/main_drawer.dart';
import 'package:restaurant/providers/filtered_meals_provider.dart';
import 'package:restaurant/providers/filters_provider.dart';
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

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();

    switch (identifier) {
      case 'meals':
        // Logic
        break;

      case 'filters':
        Navigator.of(context).push<Map<FilterName, bool>>(
          MaterialPageRoute(
            builder: (context) => const FiltersScreen(),
          ),
        );
        break;

      default:
        throw Exception('Invalid identifier: $identifier');
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoritesProvider);
    final filteredMeals = ref.watch(filteredMealsProvider);

    // init screens
    _screens = [
      TabConfig(
        title: 'Meals Categories',
        screen: CategoriesScreen(
          availableMeals: filteredMeals,
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
