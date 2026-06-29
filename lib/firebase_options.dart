// This file contains platform-specific Firebase configuration generated
// by the FlutterFire CLI. It maps each supported platform to the
// corresponding `FirebaseOptions` (API key, App ID, project ID, etc.).
//
// IMPORTANT for beginners: These values are safe to include in your
// client app (they are not secret server credentials). They are used
// by the Firebase SDK to connect to your Firebase project.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMrdqE22_Hgop_Hp18bMwGW5q-dGw1428',
    appId: '1:267423510706:android:b58be255ad46165992d9ab',
    messagingSenderId: '267423510706',
    projectId: 'studies-planner-45690',
    storageBucket: 'studies-planner-45690.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMrdqE22_Hgop_Hp18bMwGW5q-dGw1428',
    appId: '1:267423510706:ios:REPLACE_ME',
    messagingSenderId: '267423510706',
    projectId: 'studies-planner-45690',
    storageBucket: 'studies-planner-45690.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBMrdqE22_Hgop_Hp18bMwGW5q-dGw1428',
    appId: '1:267423510706:web:REPLACE_ME',
    messagingSenderId: '267423510706',
    projectId: 'studies-planner-45690',
    storageBucket: 'studies-planner-45690.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBMrdqE22_Hgop_Hp18bMwGW5q-dGw1428',
    appId: '1:267423510706:windows:REPLACE_ME',
    messagingSenderId: '267423510706',
    projectId: 'studies-planner-45690',
    storageBucket: 'studies-planner-45690.firebasestorage.app',
  );

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return ios;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return web;
      default:
        return android;
    }
  }
}

// Usage note: In `main.dart` call `Firebase.initializeApp(
// options: DefaultFirebaseOptions.currentPlatform)` so the SDK knows
// which configuration to use for the running platform.
