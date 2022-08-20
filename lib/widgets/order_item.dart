import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/orders_model.dart' as or;

class OrderItem extends StatefulWidget {
  final or.OrderItem order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: !_isExpanded
          ? min(widget.order.products!.length * 20.0 + 110, 200)
          : 95,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.time!),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: !_isExpanded
                  ? min(widget.order.products!.length * 20.0 + 10, 180)
                  : 0,
              child: ListView(
                children: widget.order.products!
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.title as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${e.quantity} x \$${e.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
