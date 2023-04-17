import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prods = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8),
      //   child: ListView(
      //     children: [
      //       ...prods.items.
      //     ],
      //   ),
      // ),
    );
  }
}
