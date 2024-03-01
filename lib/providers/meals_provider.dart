import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant/models/meal.dart';
import 'package:restaurant/mock/dummy_data.dart';

final mealsProvider = Provider<List<Meal>>((ref) => meals);
