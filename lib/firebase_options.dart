import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAK_kRIBDEMD6KUEeAWxgDlhafZn562au8",
  authDomain: "res-q-blood.firebaseapp.com",
  projectId: "res-q-blood",
  storageBucket: "res-q-blood.firebasestorage.app",
  messagingSenderId: "1063815722960",
  appId: "1:1063815722960:web:957e9f04f43ecaaef86bd5",
  measurementId: "G-Z2SWKC7J2N"
  );
}

