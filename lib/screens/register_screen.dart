import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("register screen")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100),

                //email field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 15.0,
                  ),
                  child: TextField(
                    controller: _email,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter your Email..",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 212, 212, 212),
                    ),
                  ),
                ),

                //password field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 15.0,
                  ),
                  child: TextField(
                    controller: _password,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter your Password..",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 212, 212, 212),
                    ),
                  ),
                ),

                //register button,, here we call the method which have  register logic
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 15.0,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final String email = _email.text.trim();
                      final String password = _password.text.trim();
                      _email.clear();
                      _password.clear();
                      if (email.isEmpty || password.isEmpty) {
                        print("Email or password is empty");
                        return;
                      }
                      try {
                        final user = await _authService.signupWithEmailPass(
                          email: _email.text,
                          password: _password.text,
                        );
                        if (user!.user == null) {
                          print("user not found");
                          return;
                        }
                        if (!mounted) return;

                        Navigator.pushNamed(context, "/chatscreen");
                        print('go to chatscreen');
                      } catch (e) {
                        print("$e");
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 35.0,
                      decoration: BoxDecoration(color: Colors.green),
                      child: Center(
                        child: Text(
                          "R e g i s t e r",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //if user have already an account then go to login screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/loginscreen');
                      },
                      child: Text(
                        "login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),

                //continue with google
                SizedBox(height: 15.0),
                TextButton(
                  onPressed: () async {
                    try {
                      final user = await _authService.signWithGoogle();
                      if (user!.user == null) {
                        print("user cancel the pop up");
                        return;
                      }
                      Navigator.pushNamed(context, "/chatscreen");
                      print(user.additionalUserInfo!.username);
                      print(user.additionalUserInfo!.isNewUser);
                    } catch (e) {
                      print("$e");
                      return;
                    }
                  },
                  child: Text("Continue with google"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
