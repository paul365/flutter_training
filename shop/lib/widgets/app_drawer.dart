import 'package:flutter/material.dart';
import 'package:shop/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      AppBar(
        title: const Text('Hello friend'),
        automaticallyImplyLeading: false,
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.shop),
        title: const Text('Shop'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.payment),
        title: const Text('Orders'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
        },
      )
    ]));
  }
}
