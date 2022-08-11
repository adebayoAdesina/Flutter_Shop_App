import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Center(
          child: CircularProgressIndicator(),
        ),
        imageUrl: product.imageUrl.toString(),
      ),
    );
  }
}
