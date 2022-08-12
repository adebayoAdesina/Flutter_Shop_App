import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  static const id = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    // final cartItem = context.watch
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.total,
                itemBuilder: ((context, index) {
                  final selectedCart = cart.cart!.values.toList()[index];
                  return CartCard(
                    id: selectedCart.id as String,
                    price: selectedCart.price as double,
                    title: selectedCart.title as String,
                    quantity: selectedCart.quantity!.toInt(),
                  );
                })),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Card(
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                    label: Text(
                      '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                    ),
                  )
                ],
              ),
            ),
          ),
          TextButton(
            child: Text(
              'Order Now',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
