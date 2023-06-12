import 'package:artsy/model/cart.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wear/wear.dart';

import '../../app/constants.dart';
import '../../providers/cart_provider.dart';

class HomeWearOSScreen extends StatefulWidget {
  const HomeWearOSScreen({super.key});

  @override
  State<HomeWearOSScreen> createState() => _HomeWearOSScreenState();
}

class _HomeWearOSScreenState extends State<HomeWearOSScreen> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(builder: ((context, mode, child) {
          SizeConfig.init(context);
          double w = MediaQuery.of(context).size.width;
          double h = MediaQuery.of(context).size.height;
          return Scaffold(
              backgroundColor: COLOR_SECONDARY,
              body: SafeArea(
                child: Column(children: const [_CardGrid()]),
              ));
        }));
      },
    );
  }
}

class _CardGrid extends ConsumerWidget {
  const _CardGrid();

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

          return Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(10)),
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "Hello ${Constant.user.username}",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(30),
                          fontWeight: FontWeight.bold,
                          color: COLOR_PRIMARY),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your have ${cart.length} items in your cart",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(20)),
                    ),
                    Text(
                      "and your total Price is RS $totalPrice",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(20)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "You can add more items to your cart by clicking on the button below",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(11)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/dashboard');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),textStyle: TextStyle(
                            fontSize: getProportionateScreenWidth(14)),
                        ),
                        child: const Text("Add More Items"))
                  ],
                ),
              ),
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return Center(child: Text(error.toString()));
        });
  }
}
