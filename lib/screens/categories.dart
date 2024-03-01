import 'package:flutter/material.dart';
import 'package:restaurant/mock/dummy_data.dart';
import 'package:restaurant/models/category.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/screens/meals.dart';
import 'package:restaurant/widgets/category_tile.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSelectCategory(
      {required BuildContext context, required Category category}) {
    final List<Meal> filteredMeals = widget.availableMeals
        .where((element) => element.categoryIds.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 3 / 2, // height
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return CategoryTile(
              category: category,
              onTapCategory: () {
                _handleSelectCategory(context: context, category: category);
              },
            );
          },
        ),
        builder: (context, child) {
          return Scaffold(
            body: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0, 0.3),
                  end: const Offset(0, 0),
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: child,
              ),
            ),
          );
        });
  }
}
