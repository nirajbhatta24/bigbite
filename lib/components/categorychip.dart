import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';

class CustomCategoryChip extends StatelessWidget {
  Category category;
  final Function()? onTap;
  final bool isSelected;
  CustomCategoryChip(
      {super.key, required this.category, this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(getProportionateScreenHeight(10)),
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(category.categoryName!,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    fontWeight: FontWeight.w800,
                    color:Theme.of(context).primaryColor))),
      ),
    );
  }
}
