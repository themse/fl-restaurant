import 'package:flutter/material.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/screens/categories.dart';
import 'package:restaurant/screens/meals.dart';

typedef ScreenTitle = String;

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  late List<Map<ScreenTitle, Widget>> _screens = [];

  final List<Meal> _favoriteMeals = [];

  @override
  void initState() {
    _screens = [
      {
        'Meals Categories': CategoriesScreen(
          onToggleFavorite: _toggleMealFavoriteStatus,
        )
      },
      {
        'Favorites': MealsScreen(
          meals: _favoriteMeals,
          onToggleFavorite: _toggleMealFavoriteStatus,
        )
      },
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleMealFavoriteStatus({required Meal meal}) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favorite');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite');
      });
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final MapEntry<ScreenTitle, Widget> screenConfig =
        _screens[_selectedPageIndex].entries.first;
    final String title = screenConfig.key;
    final Widget screen = screenConfig.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: screen,
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
