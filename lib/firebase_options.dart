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
    apiKey: 'AIzaSyDdvVmkHVjwVK2ftGwr03GIgNeJ5LDfJPs',
    appId: '1:727521639193:web:170dbfc663e9273fbbe388',
    messagingSenderId: '727521639193',
    projectId: 'contacts-653d0',
    authDomain: 'contacts-653d0.firebaseapp.com',
    storageBucket: 'contacts-653d0.appspot.com',
    measurementId: 'G-CMZSQBKZC1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5y4e0Ad7tTPzqB1FYxZiRfz5C8Ktnm1g',
    appId: '1:727521639193:android:0dbc96fb85a4f145bbe388',
    messagingSenderId: '727521639193',
    projectId: 'contacts-653d0',
    storageBucket: 'contacts-653d0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfzX5PN88L72sf2QHTNNRj1s5ihfaLEQE',
    appId: '1:727521639193:ios:ea94450739a24f80bbe388',
    messagingSenderId: '727521639193',
    projectId: 'contacts-653d0',
    storageBucket: 'contacts-653d0.appspot.com',
    iosClientId: '727521639193-suu8he7fpt1frapd5nocfdfdaci25erv.apps.googleusercontent.com',
    iosBundleId: 'com.example.contacts',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAfzX5PN88L72sf2QHTNNRj1s5ihfaLEQE',
    appId: '1:727521639193:ios:ea94450739a24f80bbe388',
    messagingSenderId: '727521639193',
    projectId: 'contacts-653d0',
    storageBucket: 'contacts-653d0.appspot.com',
    iosClientId: '727521639193-suu8he7fpt1frapd5nocfdfdaci25erv.apps.googleusercontent.com',
    iosBundleId: 'com.example.contacts',
  );
}