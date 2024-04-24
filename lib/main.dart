import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:news_app/features/app/splash_screen/splash_screen.dart';
import 'package:news_app/features/user_auth/presentation/pages/home_page.dart';
import 'package:news_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:news_app/features/user_auth/presentation/pages/sign_up_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCnOD3ETuQGVkPSiTSsiZewWPCGaJLe6mk",
        appId: "1:489061258768:android:49c81a07eb71fc02fd9c95",
        messagingSenderId: "489061258768",
        projectId: "flutter-firebase-9c136",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => NewsPage(),
      },
    );
  }
}
