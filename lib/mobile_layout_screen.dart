import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_sneaker/features/cart/screens/cart_screen.dart';
import 'package:g_sneaker/features/shoes/screens/home_screen.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: TabBarView(
            children: [
              HomeScreen(),
              CartScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
