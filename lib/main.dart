import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/config/theme.dart';
import 'package:restaurant/screens/tabs.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RootApp(),
    ),
  );
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const TabsScreen(),
    );
  }
}
