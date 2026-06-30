import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/auth/auth_service.dart';
import 'package:firebase_learning/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _msgController = TextEditingController();
  TextEditingController _currentPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              try {
                _authService.logOut();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Logout successful")));
                Navigator.pushReplacementNamed(context, '/loginscreen');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Logout Faild..Error: $e")),
                );
              }
            },
            icon: Icon(Icons.logout),
          ),

          //delete account
          TextButton(
            onPressed: () {
              myAlearDailog(
                context: context,
                content: "You will Lose your Account Permanently!",
                title: "Do You Wanna Delete this Account?",
                passController: _currentPassword,
                onConfirm: () async {
                  final currentPass = _currentPassword.text.trim();
                  _currentPassword.clear();
                  if (currentPass.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Enter your password')),
                    );
                    return;
                  }
                  try {
                    await _authService.deleteAccount(currentPass);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Delete succesful..")),
                    );
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/registerscreen');
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Delete Account Failed..Error: $e"),
                      ),
                    );
                  }
                },
              );
            },
            child: Text("Delete Account"),
          ),

          //change accout button
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/updatepassword");
            },
            child: Text("Change your password"),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text('Chat screen'),
      ),

      body: SafeArea(
        child: Column(
          children: [
            //Chat will be heree
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;
        
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final messagesMap =
                          messages[index].data() as Map<String, dynamic>;
                      final isMe =
                          _auth.currentUser?.email == messagesMap['user'];
                      return Align(
                      
                        alignment: isMe? Alignment.centerRight:Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                          child: Column(
                            children: [
                            
                              Text(messagesMap['user']),
                              SizedBox(height: 10.0,),
                              Container(
                                decoration: BoxDecoration(
                                  color: isMe?Colors.blue:Colors.pink,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    topLeft: !isMe?Radius.circular(0.0):Radius.circular(20.0),
                                    topRight: isMe?Radius.circular(0.0):Radius.circular(20.0),
                                  )
                                ),
                                padding: EdgeInsets.all(15.0),
                                child: Text(messagesMap['text']),
                              )
                            ],
                          ),
                        ));
                    },
                  );
                },
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 15.0,
              ),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _msgController,
                decoration: InputDecoration(
                  suffix: IconButton(
                    onPressed: () async {
                      final currentUser = _auth.currentUser?.email;
                      String textMsg = _msgController.text.trim();
        
                      if (currentUser!.isEmpty || textMsg.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Massege sending failed.")),
                        );
                        return;
                      }
                      _msgController.clear();
                      try {
                        await _firestore.collection('messages').add({
                          'text': textMsg,
                          'user': currentUser,
                          'time': FieldValue.serverTimestamp(),
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Msg sending failed. Error : $e"),
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.send, color: Colors.blue),
                  ),
                  hintText: "Type Something...",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
