import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item_model.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cart = {};

  Map<String, CartItem>? get cart => _cart;

  int get total {
    return _cart == null ? 0 : _cart.length;
  }

  double get totalAmount {
    double total = 0.0;
    _cart.forEach((key, value) {
      total += (value.price! * value.quantity!);
    });
    return total;
  }

  void removeCart(String id) {
    _cart.removeWhere((key, value) => value.id == id);
    notifyListeners();
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    _cart.containsKey(productId)
        ? _cart.update(
            productId,
            (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity! + 1,
            ),
          )
        : _cart.putIfAbsent(
            productId,
            () => CartItem(
              id: productId,
              title: title,
              price: price,
              quantity: 1,
            ),
          );
    notifyListeners();
  }

  // void removeCart(productId) {

  // }
  void clearCart() {
    _cart = {};
    notifyListeners();
  }
}
