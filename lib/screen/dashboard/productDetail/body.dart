import 'package:artsy/app/constants.dart';
import 'package:artsy/components/toproundedcontainer.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/repository/cart_repo.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final Product product;
  int? price;
  Body({super.key, required this.product, this.price});

  @override
  State<Body> createState() => _BodyState(price: price);
}

class _BodyState extends State<Body> {
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  _BodyState({this.price});
  int? price;
  int quantity = 1;
  _addtocart(Product product) async {
    var cart =
        await CartRepositoryImpl().addProductToCart(product, quantity, price!);

    if (cart) {
      setState(() {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Product Added to Cart',
          body: '${widget.product.name} added to cart successfully',
        ));

        Navigator.pushReplacementNamed(context, "/cart");
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product not added to cart'),
          ),
        );
      });
    }
  }

  _increment() {
    setState(() {
      quantity = quantity + 1;
      price = int.parse(widget.product.price!) + price!;
    });
  }

  _decrement() {
    setState(() {
      if (quantity > 1) {
        quantity = quantity - 1;
        price = price! - int.parse(widget.product.price!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(230),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                Constant.imageURL + widget.product.image!,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(38),
                width: getProportionateScreenWidth(48),
              )
            ],
          ),
          ToproundedContainer(
            color: const Color.fromARGB(133, 180, 176, 182),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(20)),
                  child: Text(
                    widget.product.name!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Text(
                    "Description: ${widget.product.description}",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "Price: ${widget.product.price}",
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Container(
                    margin:
                        EdgeInsets.only(top: getProportionateScreenHeight(40)),
                    padding:
                        EdgeInsets.only(top: getProportionateScreenHeight(40)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    child: ToproundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: COLOR_PRIMARY,
                                minimumSize: const Size.fromHeight(60)),
                            child: const Text(
                              "ADD TO CART",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.grey[300],
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) => Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "Add to Cart",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        _decrement();
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        color: Colors.red,
                                                      )),
                                                  Text(
                                                    quantity.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        _increment();
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Total Price: $price",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _addtocart(widget.product);
                                                  },
                                                  child: const Text(
                                                      "Add to Cart")),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
