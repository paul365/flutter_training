import 'package:flutter/material.dart';
import 'package:meals/models/Meals.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> meals;

  const CategoryMealsScreen({required this.meals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late List<Meal> _currentMeals;
  late String _title;
  var _isLoaded = false;

  // removeItem(String id) {
  //   setState(() {
  //     currentMeals.removeWhere((element) => element.id == id);
  //   });
  // }

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final id = routeArgs['id'];
      _title = routeArgs['title']!;
      // where similar to js filter
      _currentMeals = widget.meals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      _isLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SizedBox(
        child: ListView(children: [
          ..._currentMeals.map((m) => MealItem(
                title: m.title,
                id: m.id,
                imageUrl: m.imageUrl,
                duration: m.duration,
                complexity: m.complexity,
                affordability: m.affordability,
              ))
        ]),
      ),
    );
  }
}
