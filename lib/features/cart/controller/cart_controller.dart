import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_sneaker/features/cart/repository/cart_repository.dart';

import '../model/cart.dart';

final cartControllerProvider = Provider((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return CartController(cartRepository: cartRepository, ref: ref);
});

class CartController {
  final CartRepositoryImpl cartRepository;
  final ProviderRef ref;

  const CartController({
    required this.cartRepository,
    required this.ref,
  });

  Future<void> initState() async {
    List<Cart> carts = await ref.read(cartRepositoryProvider).getCarts();
    ref.read(selectedShoes.state).update((state) => state = carts);
  }

  Future<void> saveCarts(List<Cart> carts) async {
    await ref.read(cartRepositoryProvider).saveCarts(carts);
  }
}