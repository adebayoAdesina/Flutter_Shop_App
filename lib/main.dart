import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/appdata.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/routes/routes.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

import 'constants/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthMethod(),
        ),
        ChangeNotifierProxyProvider<AuthMethod, AppData>(
          update: (context, value, previous) =>
              AppData(value.token, previous!.products),
          create: (context) => AppData('Hello', UnmodifiableListView([])),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: Consumer<AuthMethod>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShopApp',
          theme: ThemeData(
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: kPrimaryColor,
              onPrimary: kWhiteColor,
              secondary: kSecondaryColor,
              onSecondary: kWhiteColor,
              error: Colors.red,
              onError: Colors.red,
              background: kWhiteColor,
              onBackground: kWhiteColor,
              surface: kPrimaryColor,
              onSurface: kPrimaryColor,
            ),
            fontFamily: 'Signika Negative',
          ),
          
          initialRoute: auth.isAuth ? ProductOviewViewScreen.id : AuthScreen.id,
          // initialRoute: ProductOviewViewScreen.id ,
          routes: routes,
        ),
      ),
    );
  }
}
