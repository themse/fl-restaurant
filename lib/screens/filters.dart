import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/providers/filters_provider.dart';
import 'package:restaurant/widgets/filter_tile.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);

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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FilterTile(
            value: filters[FilterName.glutenFree]!,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            onChange: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .toggleFilter(FilterName.glutenFree);
            },
          ),
          FilterTile(
            value: filters[FilterName.vegan]!,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            onChange: (isChecked) {
              ref.read(filtersProvider.notifier).toggleFilter(FilterName.vegan);
            },
          ),
          FilterTile(
            value: filters[FilterName.vegetarian]!,
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            onChange: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .toggleFilter(FilterName.vegetarian);
            },
          ),
          FilterTile(
            value: filters[FilterName.lactoseFree]!,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            onChange: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .toggleFilter(FilterName.lactoseFree);
            },
          ),
        ],
      ),
    );
  }
}
