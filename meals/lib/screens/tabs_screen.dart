import 'package:flutter/material.dart';
import 'package:meals/models/Meals.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorites_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({super.key, required this.favoriteMeals});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  static const categoriesKey = 'Categories';
  static const favoritesKey = 'Favorites';
  late List<Map<String, Object>> _pages;
  var _selectedPage = 0;

  @override
  void initState() {
    _pages = [
      {'key': categoriesKey, 'page': const CategoriesScreen()},
      {'key': favoritesKey, 'page': FavoritesScreen(widget.favoriteMeals)}
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPage]['key'] as String)),
      body: _pages[_selectedPage]['page'] as Widget,
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: categoriesKey),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: favoritesKey),
        ],
      ),
    );
    // Tap bar navigation
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Meals'),
    //         bottom: const TabBar(tabs: [
    //           Tab(icon: Icon(Icons.category), text: 'Categories'),
    //           Tab(icon: Icon(Icons.star), text: 'Favorites')
    //         ]),
    //       ),
    //       body: const TabBarView(
    //           children: [CategoriesScreen(), FavoritesScreen()]),
    //     ));
  }
}
