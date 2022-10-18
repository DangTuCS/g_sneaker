import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_sneaker/features/shoes/screens/home_screen.dart';
import '../../../utils/colors.dart';
import '../widgets/cart_card.dart';

class CartScreen extends ConsumerStatefulWidget {
  static const routeName = '/cart-screen';

  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
            const Expanded(
              child: CartCard(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorYellow,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: Icon(
          Icons.arrow_back_outlined,
          color: colorBlack,
        ),
      ),
    );
  }
}
