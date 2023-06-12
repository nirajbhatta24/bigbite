import 'package:artsy/app/constants.dart';
import 'package:artsy/data_source/remote_data_source/order_remote_datasource.dart';
import 'package:artsy/model/order.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:artsy/data_source/remote_data_source/cart_remote_datasource.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  orderProduct() async {
    Orders orders = Orders(
        products: OrderPlacement.products,
        quantity: OrderPlacement.quantity,
        amount: OrderPlacement.amount,
        status: "not paid",
        user: Constant.user);
    bool status = await OrderRemoteDataSource().addOrder(orders);

    if (status) {
      int clearCart = await CartRemoteDataSource().deleteAllCartFromUser();
      if (clearCart > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order Placed Successfully')));
        Navigator.popAndPushNamed(context, '/navigation');
      }
    }
  }

  sendtoKhalti() {
    KhaltiScope.of(context).pay(
        config: PaymentConfig(
            amount: 1000,
            productIdentity: 'product-id',
            productName: 'Cloudy Day'),
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: onSuccess,
        onFailure: onFailure,
        onCancel: onCancel);
  }

  void onSuccess(PaymentSuccessModel success) async {
    Orders orders = Orders(
        products: OrderPlacement.products,
        quantity: OrderPlacement.quantity,
        amount: OrderPlacement.amount,
        status: "paid",
        user: Constant.user);
    bool status = await OrderRemoteDataSource().addOrder(orders);

    if (status) {
      int clearCart = await CartRemoteDataSource().deleteAllCartFromUser();
      if (clearCart > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order Placed Successfully')));
        Navigator.popAndPushNamed(context, '/navigation');
      }
    }
  }

  void onFailure(PaymentFailureModel failure) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Payment Failed"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  void onCancel() {
    debugPrint("Payment Cancelled");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
        ),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: ElevatedButton(
                  onPressed: () {
                    orderProduct();
                  },
                  child: const Text("Cash On Delivery")),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: ElevatedButton(
                  onPressed: () {
                    sendtoKhalti();
                  },
                  child: const Text("Khalti Payment")),
            ),
          ]),
        )));
  }
}
