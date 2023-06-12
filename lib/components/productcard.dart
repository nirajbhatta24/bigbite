import 'package:artsy/app/constants.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';

import '../screen/dashboard/productDetail/productdetails.dart';
import '../theme/size_config.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, "/productdetail",
            arguments: ProductDetailsArguments(product: product));
      },
      child: Card(
          elevation: 5.0,
          child: InkWell(
            child: SizedBox(
              width: getProportionateScreenWidth(170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      decoration: BoxDecoration(
                        color: COLOR_GREY.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(
                        Constant.imageURL + product.image!,
                      ),
                    ),
                  ),
                  Text(product.name!,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "RS ${product.price}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w600,
                            color: COLOR_PRIMARY),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
