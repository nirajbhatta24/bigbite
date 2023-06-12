import 'package:artsy/app/constants.dart';
import 'package:flutter/material.dart';

class CheckFormFilled extends StatefulWidget {
  const CheckFormFilled({super.key});

  @override
  State<CheckFormFilled> createState() => _CheckFormFilledState();
}

class _CheckFormFilledState extends State<CheckFormFilled> {
  _checkingFormFilled() async {
    if (Constant.user.isFormFilled!) {
      await Future.delayed(const Duration(seconds: 2),
          () => Navigator.pushNamed(context, '/payment'));
    } else {
      await Future.delayed(const Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, '/address'));
    }
  }

  @override
  initState() {
    super.initState();
    _checkingFormFilled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: const [
      CircularProgressIndicator(),
      Text("Please wait"),
    ])));
  }
}
