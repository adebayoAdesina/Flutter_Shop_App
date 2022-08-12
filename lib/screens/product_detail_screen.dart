import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/appdata.dart';

class ProductDetailScreen extends StatelessWidget {
  static const id = '/detail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    final product = context.read<AppData>().findProductById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title!,
        ),
      ),
    );
  }
}
