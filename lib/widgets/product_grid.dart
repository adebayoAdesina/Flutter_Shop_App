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
    final readProvider = context.watch<AppData>();
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
          return ChangeNotifierProvider.value(
            value: product,
            builder: (context, child) => const ProductCard(),
          );
        });
  }
}
