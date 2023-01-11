// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class Registration extends StatefulWidget {
  static const String screenRoute = 'registration';
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ 
              // ignore: sized_box_for_whitespace
              Container(
                height: 200,
                child: Image.asset('images/regist.jpeg'),
              ),
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border:  OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red,
                    width: 1),
                    borderRadius:BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green,
                    width: 2),
                    borderRadius:BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
               TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border:  OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red,
                    width: 1),
                    borderRadius:BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green,
                    width: 2),
                    borderRadius:BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MyButton(
                color: Colors.red,
                 title: 'register',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                   try{
                      final newUser = await _auth.createUserWithEmailAndPassword(
                       email: email,
                       password: password);
                      Navigator.pushNamed(context, Chat.screenRoute);
                      setState(() {
                        showSpinner = false;
                      });
                      }catch(e){
                        print(e);
                      }
                  },
                  ),
          ]),
        ),
      ),
    );
  }
}