import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/Meals.dart';

import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _filteredMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegan': false,
    'vegetarian': false
  };

  _setFilters(filters) {
    setState(() {
      _filters = filters;
      _filteredMeals = DUMMY_MEALS.where((element) {
        if (_filters['glutenFree']! && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactoseFree']! && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !element.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String id) {
    final existIndex = _favoriteMeals.indexWhere((element) => element.id == id);
    if (existIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      });
    }
  }

  bool isMealFavorite(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyLarge: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1), fontSize: 15),
              titleLarge: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(meals: _filteredMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(toggleFavorite, isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(setFilters: _setFilters, currentFilters: _filters)
      },
      // if route not in routes (for dynamic routes)
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },

      // fallback to always show something.. like 404 page
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
