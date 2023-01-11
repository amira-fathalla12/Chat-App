// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:chat_app/screens/registration.dart';
import 'package:chat_app/screens/signin.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:flutter/material.dart';
class WelcomeGuys extends StatefulWidget {
  static const String screenRoute = 'welcome_guys';
  const WelcomeGuys({super.key});

  @override
  State<WelcomeGuys> createState() => _WelcomeGuysState();
}

class Static {
}

class _WelcomeGuysState extends State<WelcomeGuys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  child: Image.asset('images/logo.jpeg'),
                ),
                Text("Hi Everyone",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 12, 12, 12)
                ),)
              ],
            ),
            SizedBox(height: 30),
            MyButton(
              color: Color.fromARGB(255, 238, 106, 97),
              title: 'sign in',
              onPressed: (){
                Navigator.pushNamed(context, SignIn.screenRoute);
              },
            ),
            MyButton(
              color: Color.fromARGB(255, 50, 37, 37),
              title: 'register',
              onPressed: (){
                Navigator.pushNamed(context, Registration.screenRoute);
              },
              ),
          ],
        ),
      ),
    );
  }
}
