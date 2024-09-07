import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCshH3bo6XMCzSW5YCOIvgtEpZ1O9UCpHU',
    appId: '1:524601602707:android:d58922a0e53a77b1a59366',
    messagingSenderId: '524601602707',
    projectId: 'dojo-test-fcm',
    storageBucket: 'dojo-test-fcm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCshH3bo6XMCzSW5YCOIvgtEpZ1O9UCpHU',
    appId: '1:524601602707:android:d58922a0e53a77b1a59366',
    messagingSenderId: '524601602707',
    projectId: 'dojo-test-fcm',
    storageBucket: 'dojo-test-fcm.appspot.com',
  );
}
