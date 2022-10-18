import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:g_sneaker/features/cart/controller/cart_controller.dart';
import 'package:g_sneaker/utils/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;
import '../../shoes/model/shoes.dart';
import '../model/cart.dart';
import '../repository/cart_repository.dart';

class CartCard extends ConsumerStatefulWidget {
  const CartCard({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CartCardState();
}

class _CartCardState extends ConsumerState<CartCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Cart> selectedProducts = ref.watch(selectedShoes);

    void decreaseItem(int quantity, Cart cart) {
      List<Cart> cartList = ref.read(selectedShoes);
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i] == cart) {
          if (quantity == 1) {
            ref.watch(selectedShoes.state).update((state) {
              state.remove(cart);
              return state;
            });
          } else {
            cartList[i].quantity--;
            ref.watch(selectedShoes.state).update((state) => cartList);
          }
          setState(() {});
          ref.watch(cartControllerProvider).saveCarts(cartList);
          return;
        }
      }
    }

    void increaseItem(int quantity, Cart cart) {
      List<Cart> cartList = ref.read(selectedShoes);
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i] == cart) {
          cartList[i].quantity++;
          ref.watch(selectedShoes.state).update((state) => cartList);
          setState(() {});
          ref.watch(cartControllerProvider).saveCarts(cartList);
          return;
        }
      }
    }

    void deleteItem(int quantity, Cart cart) {
      List<Cart> cartList = ref.read(selectedShoes);
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i] == cart) {
          ref.watch(selectedShoes.state).update((state) {
            state.remove(cart);
            return state;
          });
          setState(() {});
          ref.watch(cartControllerProvider).saveCarts(cartList);
          return;
        }
      }
    }

    double sumCost() {
      double sum = 0;
      for (int i = 0; i < selectedProducts.length; i++) {
        sum += selectedProducts[i].shoes.price * selectedProducts[i].quantity;
      }
      return sum;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your cart',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$${sumCost().toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                Shoes product = selectedProducts[index].shoes;
                int quantity = selectedProducts[index].quantity;
                return SizedBox(
                  width: double.infinity,
                  height: size.width * 0.4,
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: HexColor(product.color),
                                radius: 40,
                              ),
                            ),
                            Positioned(
                              bottom: 0.8,
                              child: SizedBox(
                                width: size.width * 0.3,
                                child: Transform.rotate(
                                  angle: -math.pi / 7,
                                  child: CachedNetworkImage(
                                    imageUrl: product.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FloatingActionButton.small(
                                      heroTag: 'btn1${product.id}',
                                      backgroundColor: colorGray,
                                      onPressed: () => decreaseItem(
                                          quantity, selectedProducts[index]),
                                      child: const Icon(Icons.remove),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(quantity.toString()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    FloatingActionButton.small(
                                      heroTag: 'btn2${product.id}',
                                      backgroundColor: colorGray,
                                      onPressed: () => increaseItem(
                                          quantity, selectedProducts[index]),
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                                FloatingActionButton.small(
                                  heroTag: 'btn3${product.id}',
                                  backgroundColor: colorYellow,
                                  onPressed: () =>
                                      deleteItem(quantity, selectedProducts[index]),
                                  child: Icon(
                                    Icons.delete_forever_outlined,
                                    color: colorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
