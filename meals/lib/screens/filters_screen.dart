import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> currentFilters;
  final Function setFilters;

  const FiltersScreen(
      {super.key, required this.setFilters, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['glutenFree']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactoseFree']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildSwitch(
        bool value, String title, String subtitle, Function updateValue) {
      return SwitchListTile(
        value: value,
        onChanged: (newValue) {
          updateValue(newValue);
        },
        title: Text(title),
        subtitle: Text(subtitle),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
          actions: [
            IconButton(
                onPressed: () => {
                      widget.setFilters({
                        'glutenFree': _glutenFree,
                        'lactoseFree': _lactoseFree,
                        'vegan': _vegan,
                        'vegetarian': _vegetarian
                      })
                    },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                buildSwitch(_glutenFree, 'Gluten-free',
                    'Only include gluten-free meals', (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwitch(_lactoseFree, 'Lactose-free',
                    'Only include lactose-free meals', (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                buildSwitch(
                    _vegetarian, 'Vegetarian', 'Only include vegetarian meals',
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                buildSwitch(_vegan, 'Vegan', 'Only include vegan meals',
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
