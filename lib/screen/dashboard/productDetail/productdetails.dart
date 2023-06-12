import 'package:artsy/components/roundedbuttonicon.dart';
import 'package:artsy/screen/dashboard/productDetail/body.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Body(
          product: arguments.product,
          price: int.parse(arguments.product.price!),
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedIconBtn(
              iconData: Icons.arrow_back_ios,
              press: () =>
                  Navigator.pushReplacementNamed(context, '/navigation'),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag),
              color: Theme.of(context).primaryColor,
              iconSize: 30,
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
