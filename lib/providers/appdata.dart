import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_model.dart';

enum Show {
  favorites,
  showAll,
}

class AppData with ChangeNotifier {
  List<Product> _products = [];
    // Product(
    //   id: '1',
    //   title: 'Blue Shirt',
    //   description: 'A blue shirt',
    //   price: 30.00,
    //   imageUrl:
    //       'https://th.bing.com/th/id/OIP.5fRJB0DfiQQ0t1IR20g4WQHaKC?pid=ImgDet&rs=1',
    // ),
    // Product(
    //   id: '2',
    //   title: 'Black Shirt',
    //   description: 'A black shirt',
    //   price: 30.60,
    //   imageUrl:
    //       'https://media.missguided.com/i/missguided/ZX9221280_01?fmt=jpeg&fmt.jpeg.interlaced=true&\$product-page__main--3x\$',
    // ),
    // Product(
    //   id: '3',
    //   title: 'Red Shirt',
    //   description: 'A Red shirt',
    //   price: 58.80,
    //   imageUrl:
    //       'https://th.bing.com/th/id/R.a9ecb57dd4e13656eb01666e9666bf70?rik=KXDZJ7w1W%2b8mxg&pid=ImgRaw&r=0',
    // ),
    // Product(
    //   id: '4',
    //   title: 'Blue Shirt',
    //   description: 'A blue shirt',
    //   price: 35.60,
    //   imageUrl:
    //       'https://www.karmakula.co.uk/images/hawaiian/63d0afc173374f37a7eb1cd5e3c77456.jpg',
    // ),
    // Product(
    //   id: '5',
    //   title: 'Brown Shirt',
    //   description: 'A Brown shirt',
    //   price: 30.00,
    //   imageUrl:
    //       'https://th.bing.com/th/id/OIP.5fRJB0DfiQQ0t1IR20g4WQHaKC?pid=ImgDet&rs=1',
    // ),
  

  Future<void> fetchProduct() async {
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product.json';
    // Map<String, dynamic> data = jsonDecode(response.body);
    try {
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
      data.forEach((key, value) {
        
        _products.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          imageUrl: value['imageUrl'],
          price: value['price'],
          isFavorite: value['isFavorite']!
        ));
      });
      // print(value);
      notifyListeners();
    } catch (e) {
      // print(e.toString());
    }
    
  }

  Future<void> addProduct(Product product) async {
    String res = 'failed';
    String url =
        'https://shop-app-7c9ec-default-rtdb.firebaseio.com/product.json';
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

  void updateProduct(Product product) {
    final prodIndex =
        _products.indexWhere((element) => element.id == product.id);
    if (prodIndex > 0) {
      _products[int.parse(product.id!)] = product;
    }

    notifyListeners();
  }

  void deleteProduct(String index) {
    _products.removeWhere((element) => element.id == index);

    notifyListeners();
  }

  Product findProductById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  bool _showFavorites = false;

  UnmodifiableListView get products {
    if (_showFavorites == true) {
      return UnmodifiableListView(
          _products.where((element) => element.isFavorite).toList());
    }
    return UnmodifiableListView(_products);
  }

  void show(Show show) {
    show == Show.favorites ? _showFavorites = true : _showFavorites = false;
    notifyListeners();
  }
}
