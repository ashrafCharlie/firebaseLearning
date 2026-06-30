import 'package:firebase_learning/auth/auth_service.dart';
import 'package:firebase_learning/constItem/const.dart';
import 'package:flutter/material.dart';

class UpdateaccountScreen extends StatefulWidget {
  const UpdateaccountScreen({super.key});
   static const String id = '/updateaccountscreen';

  @override
  State<UpdateaccountScreen> createState() => _UpdateaccountScreenState();
}

class _UpdateaccountScreenState extends State<UpdateaccountScreen> {
  final AuthService _authservice = AuthService();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
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
                  Text("Change Your Password", style: kBigTextStyle),
                  SizedBox(height: 50),

                  TextField(
                    controller: currentPasswordController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Current password",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  SizedBox(height: 15.0),
                  TextField(
                    controller: newPasswordController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "New password",
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
                      //update password login

                      String currentPass = currentPasswordController.text
                          .trim();
                      String newPassword = newPasswordController.text.trim();
                      currentPasswordController.clear();
                      newPasswordController.clear();
                     
                      if (currentPass.isEmpty || newPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password field empty!")),
                        );
                        return;
                      }

                      try {
                        final returnMsg = await _authservice.changePassword(
                          currentPass,
                          newPassword,
                        );
                        Navigator.pushNamed(context, '/chatscreen');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(returnMsg.toString())),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Failed...$e")));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,

                      child: Center(child: Text("Change Password")),
                    ),
                  ),

                  SizedBox(height: 25.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Back"),
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
