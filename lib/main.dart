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

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
