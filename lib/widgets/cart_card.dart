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
      direction: DismissDirection.endToStart,
      key: Key(id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remove Cart?'),
            content:
                const Text('Are you sure sure you want to remove this goods?'),
            actions: [
              RawMaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              RawMaterialButton(
                onPressed: () {
                  context.read<Cart>().removeCart(id);
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            color: kWhiteColor,
          ),
        ),
        alignment: Alignment.centerRight,
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
