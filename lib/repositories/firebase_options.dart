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
    apiKey: 'AIzaSyAKP1ArJFrbWj-RxYIYVZuF9sh0LFSv0v0',
    appId: '1:674428428627:web:62cadd2f4aafea860301a6',
    messagingSenderId: '674428428627',
    projectId: 'ai-calc-tutor',
    authDomain: 'ai-calc-tutor.firebaseapp.com',
    storageBucket: 'ai-calc-tutor.appspot.com',
    measurementId: 'G-J2MLE9BELX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvsi0UEpxmi9EHuCWkyq-3lt2sV0u2eN4',
    appId: '1:674428428627:android:05183a27416947970301a6',
    messagingSenderId: '674428428627',
    projectId: 'ai-calc-tutor',
    storageBucket: 'ai-calc-tutor.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCt3g0ZxrwUsuDLDGwRHU10IMq6QGaaAwE',
    appId: '1:674428428627:ios:6fd6b5a178b80c800301a6',
    messagingSenderId: '674428428627',
    projectId: 'ai-calc-tutor',
    storageBucket: 'ai-calc-tutor.appspot.com',
    iosClientId: '674428428627-ucog8rhibvds868be5go758h58tm6ddn.apps.googleusercontent.com',
    iosBundleId: 'com.example.calcTutor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCt3g0ZxrwUsuDLDGwRHU10IMq6QGaaAwE',
    appId: '1:674428428627:ios:6fd6b5a178b80c800301a6',
    messagingSenderId: '674428428627',
    projectId: 'ai-calc-tutor',
    storageBucket: 'ai-calc-tutor.appspot.com',
    iosClientId: '674428428627-ucog8rhibvds868be5go758h58tm6ddn.apps.googleusercontent.com',
    iosBundleId: 'com.example.calcTutor',
  );
}
