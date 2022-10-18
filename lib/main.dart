import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_sneaker/features/shoes/widgets/product_card.dart';
import 'package:g_sneaker/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/cart/model/cart.dart';
import 'features/cart/screens/cart_screen.dart';
import 'features/shoes/screens/home_screen.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'G-Sneaker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Rubik',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: colorBlack,
              displayColor: colorBlack,
            ),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        CartScreen.routeName: (context) => const CartScreen(),
      },
    );
  }
}
