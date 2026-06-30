import 'package:flutter/material.dart';






//This is for Delete The account in chat screen
void myAlearDailog({
  required TextEditingController passController,
  required BuildContext context,
  required String content,
  required String title,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(content),
        title: Text(title),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 15.0,
            ),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: "Enter Your Password",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(onPressed: onConfirm, child: Text("Confirm")),
            ],
          ),
        ],
      );
    },
  );
}
// ------------------------------------------------------------------------



