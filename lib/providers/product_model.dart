import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavoritesValue(oldStatus) {
    isFavorite = oldStatus;
    notifyListeners();
  }

  void toggleFavoriteStatus(String token) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product/$id.json?auth=$token';
    final value = jsonEncode({'isFavorite': isFavorite});
    try {
      final response = await http.patch(Uri.parse(url), body: value);

      if (response.statusCode >= 400) {
        _setFavoritesValue(oldStatus);
      }
    } catch (e) {
      _setFavoritesValue(oldStatus);
    }

    notifyListeners();
  }
}
