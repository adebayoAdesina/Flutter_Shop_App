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

  void toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product/$id';
    final value = jsonEncode({'isFavorite': isFavorite});
    try {
      await http.patch(Uri.parse(url), body: value);
    } catch (e) {
      isFavorite = oldStatus;
    }

    notifyListeners();
  }
}
