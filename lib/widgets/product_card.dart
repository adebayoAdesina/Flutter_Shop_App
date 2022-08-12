import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/utils/color.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final int id = product.id!;
    final String imageUrl = product.imageUrl!;
    final String title = product.title!;
    final double price = product.price!;
    final bool isFavorite = product.isFavorite;
    final cart = context.read<Cart>();
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
                onPressed: () {
                  context.read<Product>().toggleFavoriteStatus();
                },
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite == true ? kSecondaryColor : kWhiteColor,
                ),
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
                onPressed: () => cart.addItem(id.toString(), price, title),
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
