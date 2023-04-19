import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetail extends StatelessWidget {
  static const routeName = '/places-detail';

  const PlacesDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          ],
        ));
  }
}
