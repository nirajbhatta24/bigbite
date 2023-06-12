import 'package:artsy/app/constants.dart';
import 'package:artsy/data_source/remote_data_source/cart_remote_datasource.dart';
import 'package:artsy/data_source/remote_data_source/order_remote_datasource.dart';
import 'package:artsy/model/order.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/providers/cart_provider.dart';
import 'package:artsy/screen/dashboard/Bottom/cart/cartbody.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/cart.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(fetchCartProvider);
    return cart.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (cart) {
          int totalPrice = 0;
          List<Product> products = [];
          List<int> quantity = [];
          for (Cart item in cart!) {
            totalPrice += item.amount!;
            products.add(item.product!);
            quantity.add(item.quantity!);
          }
          OrderPlacement.amount = totalPrice;
          OrderPlacement.products = products;
          OrderPlacement.quantity = quantity;
          
          
          return Scaffold(
            appBar: AppBar(
                title: Column(children: [
              const Text('Your Cart'),
              Text(
                " ${cart.length} items",
                style: const TextStyle(color: COLOR_GREY, fontSize: 12),
              )
            ])),
            body: const CartBody(),
            bottomNavigationBar: CheckoutCard(
              totalPrice: totalPrice,
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return Center(child: Text(error.toString()));
        });
  }
}

class CheckoutCard extends StatelessWidget {
  final int totalPrice;

  const CheckoutCard({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(15),
          horizontal: getProportionateScreenWidth(30)),
      decoration: const BoxDecoration(
        color: COLOR_WHITE,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color.fromARGB(255, 230, 228, 228)),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenWidth(50),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 236, 236),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.receipt,
                    color: COLOR_PRIMARY,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(text: ('Total: \n'), children: [
                  TextSpan(
                      text: "Rs ${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                          color: COLOR_PRIMARY))
                ])),
                SizedBox(
                  width: getProportionateScreenWidth(180),
                  child: AbsorbPointer(
                    absorbing: totalPrice == 0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkformfilled');
                        },
                        child: Text("Check out",
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(15),
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
