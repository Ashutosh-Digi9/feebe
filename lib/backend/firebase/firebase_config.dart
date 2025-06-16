import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyALJ5R9lmKbxp6r2lVpKUc9_z3sb1tBJVY",
            authDomain: "feebee-8578d.firebaseapp.com",
            projectId: "feebee-8578d",
            storageBucket: "feebee-8578d.firebasestorage.app",
            messagingSenderId: "623138223422",
            appId: "1:623138223422:web:4aeff77b8b24deb3d3e86f",
            measurementId: "G-ZM0THY6GC3"));
  } else {
    await Firebase.initializeApp();
  }
}
