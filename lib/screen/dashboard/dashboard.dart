import 'package:flutter/material.dart';
import 'package:artsy/screen/dashboard/Bottom/home.dart';
import 'package:artsy/screen/dashboard/Bottom/aboutus.dart';
import 'package:artsy/screen/dashboard/Bottom/cart/cart.dart';
import 'package:shake/shake.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const CartScreen(),
    const AboutusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'About us'),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
