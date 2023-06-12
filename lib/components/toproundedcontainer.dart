import 'package:artsy/theme/size_config.dart';
import 'package:flutter/material.dart';

class ToproundedContainer extends StatelessWidget {
  const ToproundedContainer(
      {super.key, required this.child, required this.color});
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenHeight(20)),
      padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: color,
      ),
      child: child,
    );
  }
}
