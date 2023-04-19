import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/Meals.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealDetailScreen(this.toggleFavorite, this.isMealFavorite);

  sectionHeader(ctx, headerText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        headerText,
        style: Theme.of(ctx).textTheme.titleLarge,
      ),
    );
  }

  sectionContainer(child) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15)),
      height: 250,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    // firstWhere === js find
    Meal meal = DUMMY_MEALS.firstWhere((element) => element.id == id);
    return Scaffold(
        appBar: AppBar(title: Text(meal.title)),
        body: SingleChildScrollView(
          child: Column(children: [
            Hero(
              tag: meal.id,
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            sectionHeader(context, 'Ingredients'),
            sectionContainer(
              ListView(
                children: [
                  ...meal.ingredients.map((e) => Card(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(e,
                                style: Theme.of(context).textTheme.bodyLarge)),
                      ))
                ],
              ),
            ),
            sectionHeader(context, 'Steps'),
            sectionContainer(
              ListView(
                children: [
                  ...meal.steps.map((e) {
                    int index = meal.steps.indexOf(e);
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(e),
                    );
                  })
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween(
                  begin: 0.9,
                  end: 1.0,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInCirc,
                )),
                child: child,
              ),
              child: Icon(
                isMealFavorite(id) ? Icons.star : Icons.star_border,
                key: ValueKey(isMealFavorite(id)),
              ),
            ),
            onPressed: () {
              // Navigator.of(context).pop(id);
              toggleFavorite(id);
            }));
  }
}
