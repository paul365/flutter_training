import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopv2/data/categories.dart';
import 'package:shopv2/models/category.dart';
import 'package:shopv2/models/grocery_item.dart';

class NewItemScreen extends StatefulWidget {
  static const routeName = '/new-item';
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 0;
  var _enteredCategory = categories[Categories.vegetables]!;
  var _isLoading = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      final url = Uri.https(
        'flutter-test-1-46ea9-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list.json',
      );
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _enteredCategory.title,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> resData = json.decode(response.body);

        if (context.mounted) {
          Navigator.of(context).pop(GroceryItem(
            id: resData['name'],
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _enteredCategory,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add item'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Name')),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be a valid positive number.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Quantity'),
                        ),
                        initialValue: '1',
                        onSaved: (value) {
                          _enteredQuantity = int.tryParse(value!)!;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _enteredCategory,
                        items: [
                          for (final cat in categories.entries)
                            DropdownMenuItem(
                              value: cat.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: cat.value.color,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(cat.value.title)
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _enteredCategory = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text('Reset')),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveItem,
                      child: _isLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Save'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
