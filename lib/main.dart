//import 'dart:ui';
import 'package:chat_app_sholar/pages/Login_page.dart';
import 'package:chat_app_sholar/pages/Register_page.dart';
import 'package:chat_app_sholar/pages/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main()async {

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const sholarApp());
}

class sholarApp extends StatelessWidget {
  const sholarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "LoginPage": (context) => loginPage(),
      RegisterPage.id: (context) => RegisterPage(),
           ChatPage.id: (context) => ChatPage()

      },
      initialRoute: "LoginPage",
    );
  }
}
