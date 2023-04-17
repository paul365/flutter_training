import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/orders.dart';

class OrderItemView extends StatefulWidget {
  final OrderItem order;
  const OrderItemView({
    super.key,
    required this.order,
  });

  @override
  State<OrderItemView> createState() => _OrderItemViewState();
}

class _OrderItemViewState extends State<OrderItemView> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('P${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(!_expanded ? Icons.expand_more : Icons.expand_less),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: min(widget.order.products.length * 20.0 + 50.0, 180),
              child: ListView(children: [
                ...widget.order.products.map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${e.quantity} x P ${e.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ))
              ]),
            )
        ],
      ),
    );
  }
}
