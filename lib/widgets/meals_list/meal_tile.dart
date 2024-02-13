import 'package:flutter/material.dart';
import 'package:restaurant/models/meal.dart';
import 'package:restaurant/widgets/meals_list/meal_detail_tile.dart';
import 'package:transparent_image/transparent_image.dart';

class MealTile extends StatelessWidget {
  final Meal meal;
  final Function({required String mealId}) onTap;

  const MealTile({super.key, required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => onTap(mealId: meal.id),
        child: Stack(
          children: [
            FadeInImage(
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black87,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 15),
                    MealDetailTile(
                      title: 'Duration',
                      value: meal.duration.toString(),
                    ),
                    const SizedBox(height: 15),
                    MealDetailTile(
                      title: 'Complexity',
                      value: meal.complexity.name.toUpperCase(),
                    ),
                    const SizedBox(height: 15),
                    MealDetailTile(
                      title: 'Affordability',
                      value: meal.affordability.name.toUpperCase(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
