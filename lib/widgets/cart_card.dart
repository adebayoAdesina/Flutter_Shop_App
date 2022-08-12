import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/utils/color.dart';

class CartCard extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;
  const CartCard({
    Key? key,
    required this.id,
    required this.price,
    required this.title,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (d) => context.read<Cart>().removeCart(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: FittedBox(
                child: Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity).toStringAsFixed(2)}'),
            trailing: Text('${quantity.toString()}x'),
          ),
        ),
      ),
    );
  }
}
