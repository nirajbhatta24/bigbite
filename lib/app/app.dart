import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:artsy/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 double _proximityValue = 0;

  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_8d52ddae658a4f78a682f23f36536863',
        enabledDebugging: true,

        builder: (context,navKey) {     
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter for class',
              initialRoute: '/',
              theme: TAppTheme.lightTheme,
              darkTheme: TAppTheme.darkTheme,
              themeMode: ThemeMode.system,
              routes: getAppRoutes,
              navigatorKey: navKey,
              localizationsDelegates: const[
                KhaltiLocalizations.delegate
              ],
              );
      },
      
    );
  }
}
