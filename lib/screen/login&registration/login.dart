import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repository/user_repo.dart';

class LoginScreen extends StatefulWidget {
  String? username;
  String? password;
  String? fingerprint;

  LoginScreen({super.key, this.username, this.password, this.fingerprint});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

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
    checkBiometrics();
    getAvailableBiometrics();
    super.initState();

    _usernameController.text = widget.username ?? "";
    _passwordController.text = widget.password ?? "";
    authorized = widget.fingerprint ?? "Not Authorized";
  }

  _loginUser() async {
    final user = await UserRepositoryImpl()
        .loginUser(_usernameController.text, _passwordController.text);
    if (user) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Login Sucessful',
        body: '${_usernameController.text} logged in successfully',
      ));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', _usernameController.text);
      prefs.setString('password', _passwordController.text);
      prefs.setString('fingerprint', authorized);
      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacementNamed(context, "/address");
  }

  _showMessage() {
    MotionToast.error(description: const Text('Invalid username or password'))
        .show(context);
  }

  LocalAuthentication auth = LocalAuthentication();

  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;

  String authorized = 'Not Authorized';

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on Exception catch (e) {
      print(e);
      canCheckBiometrics = false;
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on Exception catch (e) {
      print(e);
      availableBiometrics = <BiometricType>[];
    }

    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: false,
          ));
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      authorized = authenticated ? "Authorized" : "Not Authorized";
      if (authorized == "Authorized") {
        _loginUser();
      } else {
        MotionToast.error(description: const Text('Login unsuccessful'))
            .show(context);
      }
      print(authorized);
    });
  }

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _key,
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.3,
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
                    Text("Sign into your account",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: COLOR_PRIMARY)),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your username',
                      ),
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          color: COLOR_PRIMARY),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      }),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    TextFormField(
                      obscureText: !passwordVisible,
                      controller: _passwordController,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(12),
                        color: COLOR_PRIMARY,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter your password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        const Text("Forgot your password?",
                            style: TextStyle(fontSize: 15, color: COLOR_GREY)),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {
                authenticate();
              },
              icon: Icon(
                Icons.fingerprint,
                size: getProportionateScreenHeight(40),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: h * 0.07,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _loginUser();
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Brand Bold",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(12),
                      color: COLOR_GREY),
                  children: [
                    TextSpan(
                      text: "Create ",
                      style: const TextStyle(
                          fontSize: 15,
                          color: COLOR_PRIMARY,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushReplacementNamed(
                            context, "/registration"),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    ));
  }
}
