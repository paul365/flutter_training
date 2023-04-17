import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const CartListItem({
    super.key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        cart.removeItem(id);
      },
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content:
                const Text('Do you want to remove the item from the cart?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Yes')),
            ],
          ),
        );
      },
      background: Container(
        padding: const EdgeInsets.only(right: 5),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: const EdgeInsets.all(3),
              child: FittedBox(child: Text('P$price')),
            )),
            title: Text(title),
            subtitle: Text('P ${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
