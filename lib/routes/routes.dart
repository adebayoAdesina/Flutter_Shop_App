import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth_screen.dart';

import '../screens/cart_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/order_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_overview_screen.dart';
import '../screens/user_product_scree.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ProductOviewViewScreen.id: (context) => const ProductOviewViewScreen(),
  ProductDetailScreen.id: (context) => const ProductDetailScreen(),
  CartScreen.id: (context) => const CartScreen(),
  OrderScreen.id: (context) => const OrderScreen(),
  UserProduct.id: (context) => const UserProduct(),
  EditProductScreen.id: (context) => const EditProductScreen(),
  AuthScreen.id: (context) => const AuthScreen()
};
