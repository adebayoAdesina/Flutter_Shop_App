import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';

import '../providers/appdata.dart';
import '../widgets/product_grid.dart';

enum MoreIcon {
  favorites,
  showAll,
}

class ProductOviewViewScreen extends StatelessWidget {
  static const id = '/';
  const ProductOviewViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onselected(MoreIcon more, contexts) {
      more == MoreIcon.favorites
          ? contexts.show(Show.favorites)
          : contexts.show(Show.showAll);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: ((MoreIcon value) =>
                onselected(value, context.read<AppData>())),
            itemBuilder: (context) => const [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: MoreIcon.favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: MoreIcon.showAll,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Badge(
              child:
                  IconButton(onPressed: () => Navigator.pushNamed(context, CartScreen.id), icon: Icon(Icons.shopping_cart)),
              value: context.watch<Cart>().total),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
