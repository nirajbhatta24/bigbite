import 'package:artsy/components/cartitemcard.dart';
import 'package:artsy/providers/cart_provider.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/cart_repo.dart';

class CartBody extends ConsumerWidget {
  const CartBody({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(fetchCartProvider);

    return cart.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (cart) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: ListView.builder(
                itemCount: cart!.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10)),
                  child: Dismissible(
                      key: Key(cart[index].product.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: COLOR_PRIMARY,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: const [
                          Spacer(),
                          Icon(
                            Icons.delete,
                            color: COLOR_WHITE,
                            size: 30,
                          )
                        ]),
                      ),
                      onDismissed: (direction) {
                        ref
                            .read(cartProvider.notifier)
                            .removeFromCart(cart[index]);
                      },
                      child: CartItemCard(cart: cart[index])),
                ),
              ),
            ),
            
            
        error: (Object error, StackTrace stackTrace) {
          return const Center(child: Text('Something went wrong'));
        });

  }
}

