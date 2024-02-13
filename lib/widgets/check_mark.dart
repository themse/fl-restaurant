import 'package:flutter/material.dart';

class CheckMark extends StatelessWidget {
  final bool isChecked;

  const CheckMark({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return isChecked
        ? const Icon(
            Icons.check,
            color: Colors.green,
          )
        : const Icon(
            Icons.close,
            color: Colors.red,
          );
  }
}
