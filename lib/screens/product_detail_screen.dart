import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: product.imageUrl as String,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  Text('\$${product.price.toString()}',
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              child: Text(
                product.description.toString(),
                softWrap: true,
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
