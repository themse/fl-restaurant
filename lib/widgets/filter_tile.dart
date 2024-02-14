import 'package:flutter/material.dart';

class FilterTile extends StatelessWidget {
  final bool value;
  final String title;
  final String subtitle;
  final void Function(bool) onChange;

  const FilterTile({
    super.key,
    required this.value,
    required this.title,
    required this.subtitle,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      subtitle: Text(subtitle),
      onChanged: onChange,
    );
  }
}
