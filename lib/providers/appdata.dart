import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/exception/http_exception.dart';
import 'product_model.dart';

enum Show {
  favorites,
  showAll,
}

class AppData with ChangeNotifier {
  String authToken = '';
  AppData(this.authToken, this._products);

  List<Product> _products = [];

  Future<void> fetchProduct() async {
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product.json?auth=$authToken';
    // Map<String, dynamic> data = jsonDecode(response.body);
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    List<Product> dbProduct = [];
    try {
      data.forEach((key, value) {
        dbProduct.add(
          Product(
            id: key,
            title: value['title'],
            description: value['description'],
            imageUrl: value['imageUrl'],
            price: value['price'],
            // isFavorite: value['isFavorite'],
          ),
        );
      });
      _products = dbProduct;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addProduct(Product product) async {
    String res = 'failed';
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product.json?auth=$authToken';
    var value = jsonEncode({
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'isFavorite': product.isFavorite
    });
    final response = await http.post(Uri.parse(url), body: value);
    try {
      _products.add(
        Product(
          id: jsonDecode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );
      res = 'success';

      notifyListeners();
    } catch (e) {
      res = e.toString();
      print(res);
    }
  }

  Future<void> updateProduct(Product product) async {
    final prodIndex =
        _products.indexWhere((element) => element.id == product.id);

    if (prodIndex >= 0) {
      String url =
          'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product/${product.id}.json?auth=$authToken';

      final values = jsonEncode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
      });
      await http.patch(Uri.parse(url), body: values);
      _products[prodIndex] = product;
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> deleteProduct(String index) async {
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product/$index.json?auth=$authToken';

    var existingProductIndex =
        _products.indexWhere((element) => element.id == index);
    var existingProduct = _products[existingProductIndex];
    _products.removeAt(existingProductIndex);
    final value = await http.delete(
      Uri.parse(url),
    );
    // .then((value) {
    if (value.statusCode >= 400) {
      _products.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = Product();
    // }).catchError((_) {

    // });

    notifyListeners();
  }

  Product findProductById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  bool _showFavorites = false;

  List<Product> get products {
    // if (_showFavorites == true) {
    //   return
    //       _products.where((element) => element.isFavorite).toList();
    // }
    return [..._products];
  }

  void show(Show show) {
    show == Show.favorites ? _showFavorites = true : _showFavorites = false;
    notifyListeners();
  }
}
