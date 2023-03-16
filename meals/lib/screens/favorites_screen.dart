import 'package:flutter/material.dart';
import 'package:meals/models/Meals.dart';
import 'package:meals/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text('No favorites yet - start adding some!'),
      );
    } else {
      return ListView(children: [
        ...favoriteMeals.map((m) => MealItem(
              title: m.title,
              id: m.id,
              imageUrl: m.imageUrl,
              duration: m.duration,
              complexity: m.complexity,
              affordability: m.affordability,
            ))
      ]);
    }
  }
}
