import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/product_model.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/constants/color.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final String id = product.id!;
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
          child: Hero(
            tag:  'product',
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: imageUrl,
            ),
          ),
          footer: ClipRRect(
            borderRadius: borderRadius(),
            child: GridTileBar(
              backgroundColor: kGridTileBarColor,
              leading: IconButton(
                onPressed: () {
                  context
                      .read<Product>()
                      .toggleFavoriteStatus(context.watch<AuthMethod>().token);
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
                onPressed: () {
                  cart.addItem(id.toString(), price, title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '$title added',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () => cart.removeCart(
                          id.toString(),
                        ),
                      ),
                    ),
                  );
                },
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
