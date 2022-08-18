import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/orders_model.dart';
import 'package:http/http.dart' as http;
import '../models/cart_item_model.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => _orders;

  Future<void> orderNow(List<CartItem> item, double amount, String token) async {
    final timeStamp = DateTime.now();
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/order.json?auth=$token';
    final value = jsonEncode({
      'amount': amount,
      'time': timeStamp.toIso8601String(),
      'product': item
          .map((e) => {
                'id': e.id,
                'title': e.title,
                'price': e.price,
                'quantity': e.quantity
              })
          .toList(),
    });
    try {
      var response = await http.post(Uri.parse(url), body: value);
      _orders.insert(
        0,
        OrderItem(
          id: jsonDecode(response.body)['name'],
          amount: amount,
          products: item,
          time: timeStamp,
        ),
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> fetchOrders(String token) async {
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/order.json?auth=$token';
    var response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body) as Map<String, dynamic>;
    List<OrderItem> newOrder = [];
    try {
      if (data.isEmpty) {
        return;
      }
      data.forEach(
        (key, value) {
          newOrder.add(
            OrderItem(
              id: key,
              amount: value['amount'],
              time: DateTime.parse(value['time']),
              products: (value['product'] as List<dynamic>)
                  .map(
                    (e) => CartItem(
                      id: e['id'],
                      title: e['title'],
                      quantity: e['quantity'],
                      price: e['price'],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
      _orders = newOrder;
      notifyListeners();
    } catch (e) {
      e.toString();
    }
    notifyListeners();
  }
}
