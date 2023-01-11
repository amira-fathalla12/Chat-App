// ignore_for_file: prefer_const_constructors

import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/registration.dart';
import 'package:chat_app/screens/signin.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_guys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageMe app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Chat(),
      initialRoute: _auth.currentUser != null? Chat.screenRoute : WelcomeGuys.screenRoute,
      routes: {
        WelcomeGuys.screenRoute:(context) => WelcomeGuys(),
        SignIn.screenRoute:(context) => SignIn(),
        Registration.screenRoute:(context) => Registration(),
        Chat.screenRoute:(context) => Chat(),
      },
    );
  }
}
