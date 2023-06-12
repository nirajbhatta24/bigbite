import 'package:artsy/repository/user_repo.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:wear/wear.dart';
import 'package:artsy/app/routes.dart';

class LoginWearOSScreen extends StatefulWidget {
  const LoginWearOSScreen({super.key});

  @override
  State<LoginWearOSScreen> createState() => _LoginWearOSScreenState();
}

class _LoginWearOSScreenState extends State<LoginWearOSScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  _loginUser() async {
    final user = await UserRepositoryImpl()
        .loginUser(_usernameController.text, _passwordController.text);
    if (user) {
      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  _showMessage() {
    MotionToast.error(description: const Text('Invalid username or password'))
        .show(context);
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(builder: (context, mode, child) {
          return Scaffold(
              body: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: "Enter your username",
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        filled: true,
                        fillColor: COLOR_SECONDARY,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 107, 106, 106),
                            fontSize: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: "Enter your password",
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        filled: true,
                        fillColor: COLOR_SECONDARY,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 107, 106, 106),
                            fontSize: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            _loginUser();
                          },
                          child: const Text("Login"))),
                ]),
              ),
            ),
          ));
        });
      },
    );
  }
}
