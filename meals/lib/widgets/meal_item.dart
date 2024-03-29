import 'package:flutter/material.dart';
import 'package:meals/models/Meals.dart';
import 'package:meals/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  openDetail(ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName, arguments: id);
//        .then((value) {
//      if (value != null) {
//        removeItem(value);
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openDetail(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(children: [
          Stack(
            children: [
              Hero(
                tag: id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(imageUrl,
                      height: 250, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: 300,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 26, color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  const Icon(Icons.schedule),
                  const SizedBox(
                    width: 6,
                  ),
                  Text('$duration min')
                ]),
                Row(children: [
                  const Icon(Icons.work),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(complexityText)
                ]),
                Row(children: [
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(affordabilityText)
                ])
              ],
            ),
          )
        ]),
      ),
    );
  }
}
