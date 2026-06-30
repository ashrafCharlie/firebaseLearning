import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learning/firebase_options.dart';
import 'package:firebase_learning/screens/chat_screen.dart';
import 'package:firebase_learning/screens/login_screen.dart';
import 'package:firebase_learning/screens/operations/passwordreset_screen.dart';
import 'package:firebase_learning/screens/register_screen.dart';
import 'package:firebase_learning/screens/operations/updateaccount_screen.dart';
import 'package:firebase_learning/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(

      ),
      initialRoute:  "/welcomescreen" ,
      routes: {
       WelcomeScreen.id : (context)=> WelcomeScreen(),
       LoginScreen.id : (context)=> LoginScreen(),
       RegisterScreen.id : (context)=> RegisterScreen(),
      ChatScreen.id :(context)=> ChatScreen(),
       ResetPassword.id : (context)=> ResetPassword(),
      UpdateaccountScreen.id : (context)=> UpdateaccountScreen()
   
      },

    );
  }
}
