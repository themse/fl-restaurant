import 'package:flutter/material.dart';
import 'package:restaurant/widgets/filter_tile.dart';

enum FilterName { glutenFree, vegan, vegetarian, lactoseFree }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  void _addFilter(FilterName filterName) {
    switch (filterName) {
      case FilterName.glutenFree:
        setState(() {
          _isGlutenFree = !_isGlutenFree;
        });
        break;
      case FilterName.vegan:
        setState(() {
          _isVegan = !_isVegan;
        });
        break;
      case FilterName.vegetarian:
        setState(() {
          _isVegetarian = !_isVegetarian;
        });
        break;
      case FilterName.lactoseFree:
        setState(() {
          _isLactoseFree = !_isLactoseFree;
        });
        break;
      default:
        throw Exception('Invalid filterName: $filterName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();

      //   if (identifier == 'meals') {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),

      body: PopScope(
        canPop: false,
        onPopInvoked: (isPop) {
          if (isPop) return;
          Navigator.of(context).pop({
            FilterName.glutenFree: _isGlutenFree,
            FilterName.vegan: _isVegan,
            FilterName.vegetarian: _isVegetarian,
            FilterName.lactoseFree: _isLactoseFree,
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FilterTile(
              value: _isGlutenFree,
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              onChange: (isChecked) {
                _addFilter(FilterName.glutenFree);
              },
            ),
            FilterTile(
              value: _isVegan,
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              onChange: (isChecked) {
                _addFilter(FilterName.vegan);
              },
            ),
            FilterTile(
              value: _isVegetarian,
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              onChange: (isChecked) {
                _addFilter(FilterName.vegetarian);
              },
            ),
            FilterTile(
              value: _isLactoseFree,
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              onChange: (isChecked) {
                _addFilter(FilterName.lactoseFree);
              },
            ),
          ],
        ),
      ),
    );
  }
}
