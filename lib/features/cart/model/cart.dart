import 'dart:convert';

import '../../shoes/model/shoes.dart';

class Cart {
  final Shoes shoes;
  int quantity;

  Cart({required this.shoes, this.quantity = 1});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Cart && runtimeType == other.runtimeType &&
              shoes == other.shoes;

  @override
  int get hashCode => shoes.hashCode;

  static Map<String, dynamic> toMap(Cart cart) {
    return {
      'shoes': cart.shoes.toMap(),
      'quantity': cart.quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      shoes: Shoes.fromMap(map['shoes']),
      quantity: map['quantity'] as int,
    );
  }

  static String encode(List<Cart> carts) =>
      json.encode(
          carts.map<Map<String, dynamic>>((cart) => Cart.toMap(cart)).toList());

  static List<Cart> decode(String carts) =>
      (json.decode(carts) as List<dynamic>).map<Cart>((cart) =>
          Cart.fromMap(cart)).toList();
}
