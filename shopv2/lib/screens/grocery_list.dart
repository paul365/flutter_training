import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shopv2/data/categories.dart';

import 'package:shopv2/models/grocery_item.dart';
import 'package:shopv2/screens/new_item_screen.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final url = Uri.https(
      'flutter-test-1-46ea9-default-rtdb.asia-southeast1.firebasedatabase.app',
      'shopping-list.json',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data, please try again later.';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> list = json.decode(response.body);
      List<GroceryItem> loadedItems = [];
      for (final item in list.entries) {
        final cat = categories.entries
            .firstWhere(
                (element) => element.value.title == item.value['category'])
            .value;
        loadedItems.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: cat));
      }
      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong. please try again later.';
      });
    }
  }

  void _addItem() async {
    final newItem =
        await Navigator.of(context).pushNamed(NewItemScreen.routeName);

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem as GroceryItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-test-1-46ea9-default-rtdb.asia-southeast1.firebasedatabase.app',
      'shopping-list/${item.id}.json',
    );
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget getContent() {
      if (_error != null) {
        return Center(
          child: Text(_error!),
        );
      }
      if (_isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return _groceryItems.isNotEmpty
          ? ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  _removeItem(_groceryItems[index]);
                },
                confirmDismiss: (_) {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Are you sure?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
                background: Container(
                  padding: const EdgeInsets.only(right: 5),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(_groceryItems[index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryItems[index].category.color,
                  ),
                  trailing: Text(
                    _groceryItems[index].quantity.toString(),
                  ),
                ),
              ),
            )
          : const Center(
              child: Text('No items yet.'),
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add)),
        ],
      ),
      body: getContent(),
    );
  }
}
