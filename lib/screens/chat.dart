// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _fireStore = FirebaseFirestore.instance;
late User signedInUser;
class Chat extends StatefulWidget {
  static const String screenRoute = 'chat';
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageTextController = TextEditingController();
  final _auth =FirebaseAuth.instance;
 
  String? messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser (){
    try {
    final user = _auth.currentUser;
    if(user != null){
      signedInUser = user;
      print(signedInUser.email);
    }
    } catch (e) {
      print(e);
    }
  }
  //void getMessages()async{
  // final messages =await _fireStore.collection('messages').get();
   //for (var message in messages.docs){
   // print(message.data());
   //}
  //}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 171, 88, 81),
        title: Row(
          children: [
            Image.asset('images/logo-2.jpeg',height: 25),
            SizedBox(width: 10),
            Text('Hello'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){
              _auth.signOut();
               Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
             MessageStreamBuilder(),
             Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.red,
                     width: 2,
                     ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintText: 'write your message here ....',
                      border: InputBorder.none,
                    ),
                  ),
                  ),
                  TextButton(
                    onPressed: (){
                      messageTextController.clear();
                      _fireStore.collection('messages').add({
                        'text': messageText,
                        'sender': signedInUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                     child: Text(
                      'Send',
                      style: TextStyle(
                        color: Color.fromARGB(255, 120, 100, 100),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      ),
                     ),
                ],
              ),
             ),
          ],
          ),
         ),
    );
  }
}
class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('messages').orderBy('time').snapshots(),
              builder:  (context, snapshot) {
                List<MessageLine> messageWidgets = [];
                if (!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(255, 175, 76, 69)),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                for (var message in messages){
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final currentUser = signedInUser.email;
                  final messaageWidget = MessageLine(sender: messageSender, text: messageText, isMe: currentUser== messageSender,);
                  messageWidgets.add(messaageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messageWidgets,
                  ),
                );
              },
              );
  }
}
class MessageLine extends StatelessWidget {
  const MessageLine({super.key, this.sender, this.text, required this.isMe});
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender', 
          style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
          Material(
            elevation: 5,
            borderRadius:isMe? BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              
            ) : BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              
            ),
            color:isMe? Color.fromARGB(255, 83, 12, 7) : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('$text',
                            style: TextStyle(
                              fontSize: 15,color:isMe? Colors.white : Colors.black45,
                            ),
                            ),
            ),
          ),
        ],
      ),
    );
  }
}