import 'package:flutter/material.dart';
import 'package:restaurant/mock/dummy_data.dart';
import 'package:restaurant/widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void handleSelectCategory({required String categoryId}) {
    print(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals Categories'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return CategoryTile(
              category: categories[index],
              onTapCategory: handleSelectCategory,
            );
          },
        ),
      ),
    );
  }
}
