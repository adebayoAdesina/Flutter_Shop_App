import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: ProductOviewViewScreen(),
    );
  }
}
