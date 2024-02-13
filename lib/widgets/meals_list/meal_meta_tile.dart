import 'package:flutter/material.dart';

class MealMetaTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const MealMetaTile({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        )
      ],
    );
  }
}
