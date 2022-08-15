import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/appdata.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String productId;
  final String title;
  final String imageUrl;
  const UserProductItem(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        onBackgroundImageError: (exception, stackTrace) => const Center(
          child: CircularProgressIndicator(),
        ),
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.id,
                    arguments: productId);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () =>
                  context.read<AppData>().deleteProduct(productId),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
