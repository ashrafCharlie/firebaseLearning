import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Email/password register user
  Future<UserCredential?> signupWithEmailPass({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw Exception("Failed to register,,, Error: $e");
    }
  }

  //Email/password login user
  Future<UserCredential?> signInWithEmailPass({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw Exception("Failed to login,,, Error: $e");
    }
  }

  //Logout account
  Future<String?> logOut() async {
    if (_auth.currentUser == null) {
      throw Exception("User not founnd..");
    }
    try {
      await _auth.signOut();
      return "log out successful";
    } catch (e) {
      throw Exception("Log out filed.. Error: $e");
    }
  }

  //resetlink
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Resent Link Sended To your Email";
    } catch (e) {
      throw Exception("Password Reset Failed error: $e");
    }
  }


  //change password
  Future<String?> changePassword(
    String currentPasword,
    String newPassword,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
         throw Exception("User not found");
      }
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPasword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return "password reset successful";
    } catch (e) {
      throw Exception("Password change failed..error: $e");
    }
  }

  //delete account
  Future<String?> deleteAccount(String currentPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        throw Exception("User not found");
      }
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.delete();
      await _auth.signOut();
      return "Account Delete Successful";
    } catch (e) {
      throw Exception("Account Delete Failed.. Error: $e");
    }
  }


  //google signin/signup
  Future<UserCredential?> signWithGoogle() async {
    try {
      //google plugin ready kore,,
      await GoogleSignIn.instance.initialize();

      //account picker pop up hoy,, and user return kore
      final user = await GoogleSignIn.instance.authenticate();
      
      //token and user info collecet
      final googleauth = user.authentication;

      //google token diye firebase  credential banay,,
      final userCredential = GoogleAuthProvider.credential(
        idToken: googleauth.idToken,
      );

      //firebase a login/signup complete kore,, new user holey signup old user holey signin
      return await _auth.signInWithCredential(userCredential);
    } catch (e) {
       throw Exception(" Google signup Failed Failed.. Error: $e");
    }
  }
}
