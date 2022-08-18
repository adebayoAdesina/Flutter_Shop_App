import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../widgets/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const id = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading = true;

  void getCarts() async {
    await context
        .read<Orders>()
        .fetchOrders(context.watch<AuthMethod>().token)
        .then(
          (value) => setState(
            () {
              _isLoading = false;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: context
              .read<Orders>()
              .fetchOrders(context.watch<AuthMethod>().token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              _isLoading = false;
            }
            if (snapshot.error != null) {
              return const Text('An error occur');
            } else {
              final orders = context.watch<Orders>();
              return ModalProgressHUD(
                inAsyncCall: _isLoading,
                child: RefreshIndicator(
                  onRefresh: () async {
                    getCarts();
                  },
                  child: ListView.builder(
                      itemCount: orders.orders.length,
                      itemBuilder: (context, index) {
                        final listOrder = orders.orders[index];
                        return OrderItem(order: listOrder);
                      }),
                ),
              );
            }
          }),
    );
  }
}
