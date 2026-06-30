import 'package:firebase_learning/auth/auth_service.dart';
import 'package:firebase_learning/constItem/const.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
   static const String id = '/passwordresetscreen';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _resetemail = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 25.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Forget Your password?", style: kBigTextStyle),
                  SizedBox(height: 50),
                  Text(
                    "Enter An Email, You will Recieve A password reset Link",
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _resetemail,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  GestureDetector(
                    onTap: () async {
                      final AuthService _authservice = AuthService();
                      final String email = _resetemail.text.trim();
                      _resetemail.clear();
                      try {
                        await _authservice.resetPassword(email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Check Your email inbox,a  password reset link will be there!",
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Failed..Error: $e",
                            ),duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,

                      child: Center(child: Text("Forget Password")),
                    ),
                  ),
                  SizedBox(height: 15.0),

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
