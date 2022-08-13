import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  int? id;
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

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

