import 'package:artsy/app/constants.dart';
import 'package:artsy/model/cart.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < cart.id!.length; i++) {
      debugPrint(cart.product!.image);
    }
    return Row(children: [
      Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(8)),
        child: SizedBox(
          width: getProportionateScreenWidth(80),
          child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: const EdgeInsets.all(5),
                height: getProportionateScreenHeight(80),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 202, 203, 214),
                    borderRadius: BorderRadius.circular(15)),
                child: cart.product!.image != null
                    ? Image.network(Constant.imageURL + cart.product!.image!)
                    : const Center(child: Text('No Image')),
              )),
        ),
      ),
      SizedBox(
        width: getProportionateScreenWidth(20),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cart.product!.name!,
            maxLines: 2,
            style: TextStyle(
                fontSize: getProportionateScreenHeight(16),
                fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(
              text: cart.product!.price!,
              style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w800,
                  color: COLOR_PRIMARY))),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Quantity: ${cart.quantity}',
            style: TextStyle(
                fontSize: getProportionateScreenHeight(11),
                fontWeight: FontWeight.w500,
                color: COLOR_DARK),
          )
        ],
      )
    ]);
  }
}
