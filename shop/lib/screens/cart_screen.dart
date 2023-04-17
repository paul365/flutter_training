import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_list_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total P',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(cart.totalAmount.toString()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    child: Text('Order now!'),
                  ),
                ]),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ...cart.items.values.map(
                (value) => CartListItem(
                  id: value.id,
                  title: value.title,
                  quantity: value.quantity,
                  price: value.price,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
