import 'dart:async';
import 'package:artsy/app/constants.dart';
import 'package:artsy/screen/login&registration/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String data = '';
  String? username;
  String? password;
  String? fingerprint;

  _getDataFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString('token');
    username = prefs.getString('username');
    password = prefs.getString('password');
    fingerprint = prefs.getString('fingerprint');

    username ?? "";
    password ?? "";
    fingerprint ?? "Not Authorized";

    if (value != null) {
      setState(() {
        data = value;
        Constant.token = data;
      });
    } else {
      setState(() {
        data = 'No data found';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final isWalthroughShown = prefs.getBool("isWalkthroughShown") ?? false;
      _getDataFromSharedPref();
      if (isWalthroughShown) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(
                username: username,
                password: password,
                fingerprint: fingerprint)));
      } else {
        Navigator.pushReplacementNamed(context, "/walkthrough");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
            width: screen.width,
            height: screen.height,
            child: Stack(
              children: [
                Center(
                    child: Image.asset(
                  "assets/images/logo.png",
                  height: 300,
                )),
                Positioned(
                  width: screen.width,
                  bottom: 30,
                  child: Text(
                    "Powered by BigBite",
                    style: themeData.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
