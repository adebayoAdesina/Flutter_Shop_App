import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/appdata.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import '../providers/product_model.dart';

class UserProduct extends StatelessWidget {
  static const id = '/user-product';
  const UserProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.watch<AppData>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, EditProductScreen.id),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: product.products.length,
          itemBuilder: (context, index) {
            Product currentProduct = product.products[index];
            return UserProductItem(
              title: currentProduct.title!,
              imageUrl: currentProduct.imageUrl!,
            );
          }),
    );
  }
}
