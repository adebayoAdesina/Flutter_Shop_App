import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/utils/color.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final double price;
  const ProductCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius(),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          ProductDetailScreen.id,
          arguments: id,
        ),
        child: GridTile(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl: imageUrl,
          ),
          footer: ClipRRect(
            borderRadius: borderRadius(),
            child: GridTileBar(
              backgroundColor: kGridTileBarColor,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                '\$ ${price.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius borderRadius() {
    return const BorderRadius.only(
      topLeft: Radius.circular(
        20,
      ),
      topRight: Radius.circular(
        20,
      ),
    );
  }
}
