import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  static const id = '/detail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          routeArg.toString(),
        ),
      ),
    );
  }
}
