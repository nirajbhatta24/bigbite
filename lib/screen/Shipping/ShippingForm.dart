import 'package:artsy/repository/address_repo.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({super.key});

  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  final _key = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  _saveAddress() async {
    final address = await AddressRepositoryImpl().addAddress(
        _addressController.text, _cityController.text, _stateController.text);

    _showMessage(address);
  }

  _showMessage(bool status) {
    if (status) {
      Navigator.pushReplacementNamed(context, '/navigation');
      MotionToast.success(
        description: const Text('Address Added'),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text('Error'),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Address'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Enter your shipping details',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: "Your address",
                    icon: Icon(Icons.location_on),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: COLOR_GREY,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: COLOR_PRIMARY,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: "City",
                    icon: Icon(Icons.location_city),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: COLOR_GREY,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: COLOR_PRIMARY,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: "State",
                    icon: Icon(Icons.map_outlined),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: COLOR_GREY,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: COLOR_PRIMARY,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    _saveAddress();
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
