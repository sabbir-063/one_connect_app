// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDhAMKyuHgttJEJXpyhZBpQK1Wk_Q2Va-0',
    appId: '1:154462080487:web:926e26eb764b6157b94142',
    messagingSenderId: '154462080487',
    projectId: 'one-connect-app-66a93',
    authDomain: 'one-connect-app-66a93.firebaseapp.com',
    storageBucket: 'one-connect-app-66a93.appspot.com',
    measurementId: 'G-MK1B65N2YN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNCIIt9m-DdHcjY4sd-qgDz_-9TOM0C-g',
    appId: '1:154462080487:android:e5e1a893191102b3b94142',
    messagingSenderId: '154462080487',
    projectId: 'one-connect-app-66a93',
    storageBucket: 'one-connect-app-66a93.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzBIIEO3G7o33o_mcZB5uXdoi7PYillBg',
    appId: '1:154462080487:ios:af93f5e59315288cb94142',
    messagingSenderId: '154462080487',
    projectId: 'one-connect-app-66a93',
    storageBucket: 'one-connect-app-66a93.appspot.com',
    iosBundleId: 'com.example.oneConnectApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzBIIEO3G7o33o_mcZB5uXdoi7PYillBg',
    appId: '1:154462080487:ios:af93f5e59315288cb94142',
    messagingSenderId: '154462080487',
    projectId: 'one-connect-app-66a93',
    storageBucket: 'one-connect-app-66a93.appspot.com',
    iosBundleId: 'com.example.oneConnectApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDhAMKyuHgttJEJXpyhZBpQK1Wk_Q2Va-0',
    appId: '1:154462080487:web:db06c5915ba68ae3b94142',
    messagingSenderId: '154462080487',
    projectId: 'one-connect-app-66a93',
    authDomain: 'one-connect-app-66a93.firebaseapp.com',
    storageBucket: 'one-connect-app-66a93.appspot.com',
    measurementId: 'G-H7L9DTNCY2',
  );
}