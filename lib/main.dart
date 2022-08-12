import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/appdata.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

import 'utils/color.dart';

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
          create: (context) => AppData(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        )
      ],
      child: MaterialApp(
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
          //  textTheme: TextTheme(),
        ),
        initialRoute: ProductOviewViewScreen.id,
        routes: {
          ProductOviewViewScreen.id: (context) =>
              const ProductOviewViewScreen(),
          ProductDetailScreen.id: (context) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
