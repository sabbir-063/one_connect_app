import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import './app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //Widget Binding
  //Init Local Storage
  //await Native Splash
  //Initialize firebase
  //Initialize authentication

  AwesomeNotifications().initialize(
    null, // Icon for the notification
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
