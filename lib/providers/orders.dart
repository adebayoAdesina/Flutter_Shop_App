import 'package:flutter/material.dart';
import 'package:shop_app/models/orders_model.dart';

import '../models/cart_item_model.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => _orders;

  void orderNow(List<CartItem> item, double amount) {
    _orders.insert(
      0,
      OrderItem(
        id: _orders.isEmpty ? 1 : _orders.length + 1,
        amount: amount,
        products: item,
        time: DateTime.now(),
      ),
    );
    print(_orders);
    notifyListeners();
  }


}
