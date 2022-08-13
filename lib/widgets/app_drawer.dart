import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/utils/color.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          const DrawerHeader(
              child: Text(
            'Hello Friend',
            style: TextStyle(color: kWhiteColor, fontSize: 30),
          )),
          const Divider(),
          ListTile(
            iconColor: kWhiteColor,
            textColor: kWhiteColor,
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductOviewViewScreen.id),
          ),
          const Divider(),
          ListTile(
            iconColor: kWhiteColor,
            textColor: kWhiteColor,
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductOviewViewScreen.id),
          )
        ],
      ),
    );
  }
}