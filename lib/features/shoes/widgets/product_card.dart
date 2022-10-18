import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/colors.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/model/cart.dart';
import 'dart:math' as math;

import '../../cart/repository/cart_repository.dart';
import '../controller/shoes_controller.dart';
import '../model/shoes.dart';

class ProductCard extends ConsumerStatefulWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
    });
  }

  void selectItem(int index, Shoes shoes) {
    var carts = ref.read(selectedShoes);
    if (carts.contains(Cart(shoes: shoes))) {
      ref.read(selectedShoes.state).update((state) {
        state.remove(Cart(shoes: shoes));
        ref.read(cartRepositoryProvider).saveCarts(
              ref.read(selectedShoes),
            );
        return state;
      });
    } else {
      ref.read(selectedShoes.state).update((state) {
        state.add(Cart(shoes: shoes));
        ref.read(cartRepositoryProvider).saveCarts(
          ref.read(selectedShoes),
        );
        return state;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var carts = ref.watch(selectedShoes);
    List<Shoes> products = ref.watch(shoesControllerProvider).getShoesItems();
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: products.length,
          itemBuilder: (context, index) {
            Shoes product = products[index];
            bool isSelected = carts.contains(Cart(shoes: product));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor(product.color),
                      ),
                    ),
                    Positioned(
                      child: SizedBox(
                        width: size.width * 0.8,
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
                const SizedBox(
                  height: 12,
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(product.description),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isSelected
                        ? CircleAvatar(
                            backgroundColor: colorYellow,
                            child: IconButton(
                              onPressed: () {
                                selectItem(index, product);
                                setState(() {

                                });
                              },
                              icon: Icon(
                                Icons.done,
                                color: colorBlack,
                              ),
                            ),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: colorYellow,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                            ),
                            onPressed: () {
                              selectItem(index, product);
                              setState(() {

                              });
                            },
                            child: Text(
                              'ADD TO CARD',
                              style: TextStyle(color: colorBlack),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            );
          }),
    );
  }
}
