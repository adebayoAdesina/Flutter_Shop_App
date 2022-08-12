import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const id = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<Orders>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.orders.length,
          itemBuilder: (context, index) {
            final listOrder = orders.orders[index];
            return OrderItem(order: listOrder);
          }),
    );
  }
}
