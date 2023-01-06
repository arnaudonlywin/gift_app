// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyChAMedFKQ4zFJ6dXsxX6lkGUNqjPopQb8',
    appId: '1:90476709612:web:296b051556fd9673ef07c9',
    messagingSenderId: '90476709612',
    projectId: 'simplon-alt3-cda',
    authDomain: 'simplon-alt3-cda.firebaseapp.com',
    storageBucket: 'simplon-alt3-cda.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBG6X-qzkVT6IOU_5NUg-iZk73MUE-1n9c',
    appId: '1:90476709612:android:09369dbad738a652ef07c9',
    messagingSenderId: '90476709612',
    projectId: 'simplon-alt3-cda',
    storageBucket: 'simplon-alt3-cda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDD2l8h0a9U_6Pt0qweZ6NNot-p1IFpgf8',
    appId: '1:90476709612:ios:0ac1553409ec3b44ef07c9',
    messagingSenderId: '90476709612',
    projectId: 'simplon-alt3-cda',
    storageBucket: 'simplon-alt3-cda.appspot.com',
    iosClientId: '90476709612-8502abnecn5q84sb5ic0l8inuv9th7nn.apps.googleusercontent.com',
    iosBundleId: 'com.example.giftApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDD2l8h0a9U_6Pt0qweZ6NNot-p1IFpgf8',
    appId: '1:90476709612:ios:0ac1553409ec3b44ef07c9',
    messagingSenderId: '90476709612',
    projectId: 'simplon-alt3-cda',
    storageBucket: 'simplon-alt3-cda.appspot.com',
    iosClientId: '90476709612-8502abnecn5q84sb5ic0l8inuv9th7nn.apps.googleusercontent.com',
    iosBundleId: 'com.example.giftApp',
  );
}