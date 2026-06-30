import 'package:firebase_learning/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login screen")),
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

                //password filed
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

                //login to an account, here we call login authentication
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
                      try {
                        final user = await _authService.signInWithEmailPass(
                          email: email,
                          password: password,
                        );

                        if (user!.user == null) {
                          print("Login failed, user not found");
                          return;
                        }
                        Navigator.pushNamed(context, '/chatscreen');
                      } catch (e) {
                        print("Error is : $e");
                      }
                      print("login");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 35.0,
                      decoration: BoxDecoration(color: Colors.pink[200]),
                      child: Center(
                        child: Text(
                          "L o g i n",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                           Navigator.pushReplacementNamed(context,  "/resetpassword");
                        }, 
                        child: Text("Forget Password",),
                        ),
                    ],
                  ),
                ),

                //Don't have any account? go to register screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/registerscreen');
                      },
                      child: Text(
                        "Register",
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
