import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/widgets/product_card.dart';

import '../widgets/product_grid.dart';

class ProductOviewViewScreen extends StatelessWidget {
  static const id = '/';
  const ProductOviewViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: const ProductGrid(),
    );
  }
}

