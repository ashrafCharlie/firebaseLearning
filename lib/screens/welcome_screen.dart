import 'package:firebase_learning/constItem/const.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome buddy!", style: kBigTextStyle),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/registerscreen");
                },
                child: Text("Register new Account"),
              ),
              SizedBox(height: 50),
              ElevatedButton(onPressed: () {
                   Navigator.pushNamed(context, "/loginscreen");
              }, child: Text("login here")),
            ],
          ),
        ),
      ),
    );
  }
}
