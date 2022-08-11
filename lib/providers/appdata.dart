import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/product_model.dart';

class AppData with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: 1,
      title: 'Blue Shirt',
      description: 'A blue shirt',
      price: 30.00,
      imageUrl:
          'https://th.bing.com/th/id/OIP.5fRJB0DfiQQ0t1IR20g4WQHaKC?pid=ImgDet&rs=1',
    ),
    Product(
      id: 2,
      title: 'Black Shirt',
      description: 'A black shirt',
      price: 30.60,
      imageUrl:
          'https://media.missguided.com/i/missguided/ZX9221280_01?fmt=jpeg&fmt.jpeg.interlaced=true&\$product-page__main--3x\$',
    ),
    Product(
      id: 3,
      title: 'Blue Shirt',
      description: 'A blue shirt',
      price: 58.80,
      imageUrl:
          'https://th.bing.com/th/id/R.a9ecb57dd4e13656eb01666e9666bf70?rik=KXDZJ7w1W%2b8mxg&pid=ImgRaw&r=0',
    ),
    Product(
      id: 4,
      title: 'Blue Shirt',
      description: 'A blue shirt',
      price: 35.60,
      imageUrl:
          'https://www.karmakula.co.uk/images/hawaiian/63d0afc173374f37a7eb1cd5e3c77456.jpg',
    ),
    Product(
      id: 5,
      title: 'Blue Shirt',
      description: 'A blue shirt',
      price: 30.00,
      imageUrl:
          'https://th.bing.com/th/id/OIP.5fRJB0DfiQQ0t1IR20g4WQHaKC?pid=ImgDet&rs=1',
    ),
  ];


  UnmodifiableListView get products => UnmodifiableListView(_products);
}
