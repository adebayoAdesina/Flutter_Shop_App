import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/utils/color.dart';

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
      footer: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            20,
          ),
          topRight: Radius.circular(
            20,
          ),
        ),
        child: GridTileBar(
          backgroundColor: kGridTileBarColor,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
          title: Text(
            product.title.toString(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            '\$ ${product.price}',
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag),
          ),
        ),
      ),
    );
  }
}
