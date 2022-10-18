import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_sneaker/features/cart/controller/cart_controller.dart';
import 'package:g_sneaker/utils/colors.dart';

import '../../cart/screens/cart_screen.dart';
import '../widgets/product_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>{
  @override
  void initState() {
    super.initState();
    ref.read(cartControllerProvider).initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 26 * 1.5,
              height: 50 * 1.5,
              child: Image.asset('assets/nike.png'),
            ),
            const Text(
              'Our Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const ProductCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorYellow,
        onPressed: () {
          Navigator.pushReplacementNamed(context, CartScreen.routeName);
        },
        child: Icon(Icons.done,color: colorBlack,),
      ),
    );
  }
}
