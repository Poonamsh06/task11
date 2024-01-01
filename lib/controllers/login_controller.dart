import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:task2/views/admin_view.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailOrPhone = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signIn() async {
    try {
      String emailOrPhoneNumber = emailOrPhone.text.trim();
      String enteredPassword = password.text;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email or phone no', isEqualTo: emailOrPhoneNumber)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        var storedPassword = userData['password'];

        if (enteredPassword == storedPassword) {
          print('User signed in successfully!');
          Get.to(() => AdminPage());
        } else {
          print('Incorrect password');
          // Handle incorrect password
        }
      } else {
        print('User not found');
        // Handle user not foundreha
      }
    } catch (e) {
      print('Error during sign in: $e');
    }
  }
}
