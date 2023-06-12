import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key? key,
    required this.iconData,
    required this.press,
  }) : super(key: key);
  final IconData iconData;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
            backgroundColor: COLOR_WHITE,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: Icon(
            iconData,
            color: COLOR_BLACK,
          ),
        ));
  }
}