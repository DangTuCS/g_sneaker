import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_sneaker/features/cart/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final selectedShoes = StateProvider<List<Cart>>((ref) => []);

final cartRepositoryProvider = Provider((ref) => CartRepositoryImpl());

abstract class CartRepository {
  Future<List<Cart>> getCarts();
  Future<void> saveCarts(List<Cart> carts);
}

const _cartKey = 'cart_key';

class CartRepositoryImpl implements CartRepository {
  // final Reader _read;

  // CartRepositoryImpl(this._read);
  CartRepositoryImpl();

  @override
  Future<List<Cart>> getCarts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Cart> carts = Cart.decode(prefs.getString(_cartKey) ?? '[]');
    return carts;
  }

  @override
  Future<void> saveCarts(List<Cart> carts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, Cart.encode(carts));
  }

}