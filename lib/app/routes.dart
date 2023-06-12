import 'package:artsy/screen/Checkout/checkout.dart';
import 'package:artsy/screen/Profile/ProfilePage.dart';
import 'package:artsy/screen/Shipping/CheckFormField.dart';
import 'package:artsy/screen/Shipping/ShippingForm.dart';
import 'package:artsy/screen/WearOS/dashboard.dart';
import 'package:artsy/screen/WearOS/home.dart';
import 'package:artsy/screen/WearOS/login.dart';
import 'package:artsy/screen/dashboard/Bottom/cart/cart.dart';
import 'package:artsy/screen/dashboard/dashboard.dart';
import 'package:artsy/screen/dashboard/productDetail/productdetails.dart';
import 'package:artsy/screen/login&registration/login.dart';
import 'package:artsy/screen/login&registration/registration.dart';
import 'package:artsy/screen/onboarding_screens/page1.dart';
import 'package:artsy/screen/onboarding_screens/page2.dart';
import 'package:artsy/screen/googlemap/googlemap.dart';
import 'package:flutter/cupertino.dart';
import '../screen/Profile/UpdateProfileScreen.dart';
import '../screen/dashboard/Bottom/aboutus.dart';

var getAppRoutes = <String, WidgetBuilder>{
  // '/': (context) => const LoginWearOSScreen(),
  // '/dashboard': (context) => const DashboardWearOSScreen(),
  // '/home':(context) => const HomeWearOSScreen(),
  '/': (context) => const OnboardingScreen(),
  '/registration': (context) => const RegistrationScreen(),
  '/walkthrough': (context) => const WalkthroughScreen(),
  '/login': (context) => LoginScreen(),
  '/navigation': (context) => const BottomNavigation(),
  '/productdetail': (context) => const ProductDetailScreen(),
  '/cart': (context) => const CartScreen(),
  '/aboutus': (context) => const AboutusScreen(),
  '/map': (context) => const GoogleMapScreen(),
  '/profile': ((context) => const ProfilePageScreen()),
  '/updateprofile': ((context) => const UpdateProfileScreen()),
  '/address': ((context) => const ShippingAddressForm()),
  '/payment': ((context) => const PaymentScreen()),
  '/checkformfilled': ((context) => const CheckFormFilled()),
};
