import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:task2/views/admin_view.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final DateTime timestamp = DateTime.now();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final userName = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final isPasswordValid = true.obs; // Track password validation

  Future<void> signUp() async {
    try {
      String emailOrPhone = email.text.trim();
      String userPassword = password.text;

      if (userPassword.length < 6) {
        // Show SnackBar if password is too short
        Get.snackbar('Error', 'Password should be at least 6 characters.');

        // Set isPasswordValid to false to indicate invalid password
        isPasswordValid(false);

        return; // Return to exit the function if password is too short
      }

      // Reset isPasswordValid to true
      isPasswordValid(true);

      UserCredential userCredential;
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailOrPhone)) {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailOrPhone,
          password: userPassword,
        );

        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'username': userName.text,
          'email or phone no': emailOrPhone,
          'timestamp': timestamp,
          'phone': phone.text,
          'password': password.text,
        });
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailOrPhone,
          password: userPassword,
        );

        await userCredential.user
            ?.updatePhoneNumber(PhoneAuthProvider.credential(
          verificationId: 'dummy_verification_id',
          smsCode: emailOrPhone,
        ));
      }

      // If registration is successful and password is valid, navigate to admin page
      if (isPasswordValid.value) {
        Get.to(() => AdminPage());
      }

      print('User registered successfully!');
    } catch (e) {
      print('Error during registration: $e');
    }
  }
}
