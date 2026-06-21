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
