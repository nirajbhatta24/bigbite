import 'dart:io';
import 'package:artsy/app/permission.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:artsy/model/user.dart';
import 'package:artsy/repository/user_repo.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();

  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.requestCameraPermission();
  }

  _saveUser() async {
    User user = User(
      fname: _fnameController.text,
      lname: _lnameController.text,
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );

    int status = await UserRepositoryImpl().addUser(_img, user);
    _showMessage(status);
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _showMessage(int status) {
    if (status > 0) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Registered Successfully',
        body: 'Thankyou for registration, you are now a part of BigBite',
      ));

      _fnameController.clear();
      _lnameController.clear();
      _emailController.clear();
      _usernameController.clear();
      _passwordController.clear();
      _cpasswordController.clear();
      MotionToast.success(
        description: const Text('User registered successfully'),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text('Error'),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _key,
        child: Column(children: [
          Container(
            width: w,
            height: h * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/wave.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("WELCOME TO BigBite",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(30),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans Bold')),
                    Text("Create an account",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: Color.fromARGB(255, 150, 118, 118))),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                  ])),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.grey[300],
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _browseImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _browseImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.image),
                        label: const Text('Gallery'),
                      )
                    ],
                  ),
                ),
              );
            },
            child: SizedBox(
                height: getProportionateScreenHeight(180),
                width: double.infinity - 500,
                child: CircleAvatar(
                  radius: getProportionateScreenHeight(20),
                  backgroundImage: _img == null
                      ? const AssetImage('assets/images/profile.jpg')
                          as ImageProvider
                      : FileImage(_img!),
                )),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: TextFormField(
              controller: _fnameController,
              decoration: const InputDecoration(
                labelText: 'Enter your First name',
              ),
              style: TextStyle(
                fontSize: getProportionateScreenHeight(12),
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Firstname';
                }
                return null;
              }),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: TextFormField(
              controller: _lnameController,
              decoration: const InputDecoration(
                labelText: 'Enter your Last name',
              ),
              style: TextStyle(
                fontSize: getProportionateScreenHeight(12),
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Last name';
                }
                return null;
              }),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your Email',
              ),
              style: TextStyle(
                fontSize: getProportionateScreenHeight(12),
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Email';
                }
                return null;
              }),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter your Username',
              ),
              style: TextStyle(
                fontSize: getProportionateScreenHeight(12),
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Username';
                }
                return null;
              }),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter your password',
              ),
              style: TextStyle(
                fontSize: getProportionateScreenHeight(12),
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              }),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: TextFormField(
              obscureText: true,
              controller: _cpasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
              style: TextStyle(
                fontSize: getProportionateScreenHeight(12),
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                  // } else if (value != _passwordController) {
                  //   return 'password and confirm password does not match';
                  // }
                }
                return null;
              }),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: SizedBox(
              height: h * 0.07,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    _saveUser();
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    fontFamily: "Brand Bold",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: h * 0.05),
          RichText(
            text: TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(12),
                    color: const Color.fromARGB(159, 46, 33, 51)),
                children: [
                  TextSpan(
                    text: "Login ",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 122, 64, 142),
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Navigator.pushReplacementNamed(context, "/login"),
                  ),
                ]),
          ),
        ]),
      ),
    ));
  }
}
