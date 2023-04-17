import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_item_view.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView(
        children: [...ordersProvider.items.map((e) => OrderItemView(order: e))],
      ),
    );
  }
}
