import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/product_card.dart';

import '../models/product_model.dart';
import '../providers/appdata.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readProvider = context.read<AppData>();
    // final watchProvider = context.watch<AppData>();
    return GridView.builder(
        itemCount: readProvider.products.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          childAspectRatio: 2.2 / 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemBuilder: (context, index) {
          Product product = readProvider.products[index];
          return ProductCard(
            id: product.id as int,
            imageUrl: product.imageUrl as String,
            title: product.title as String,
            price: product.price as double,
          );
        });
  }
}
