import 'package:artsy/state/objectbox_state.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'helper/objectbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti/khalti.dart';

//AIzaSyA-uXjnf9RzPn8tc4ql_uEI0ToVJCWNrS4  API key for google maps

void main() async {
  AwesomeNotifications().initialize(
    'resource://drawable/launcher',
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color.fromARGB(255, 214, 172, 247),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: true),
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Khalti.init(
      publicKey: 'test_public_key_8d52ddae658a4f78a682f23f36536863',
      enabledDebugging: false);
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}
