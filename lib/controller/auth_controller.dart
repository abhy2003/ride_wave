import 'dart:developer';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/otp_verification_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  // Function to validate the phone number format
  bool validatePhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^\+[1-9]\d{1,14}$');
    return regex.hasMatch(phoneNumber);
  }

  // Function to handle phone number verification
  Future<void> verifyPhoneNumber(BuildContext context) async {
    String phoneNumber = '+91' + phoneController.text.trim();

    if (validatePhoneNumber(phoneNumber)) {
      isLoading(true);

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          log(error.toString());
          isLoading(false);
          Get.snackbar('Verification failed', error.message ?? 'Error');
        },
        codeSent: (verificationId, forceResendingToken) {
          isLoading(false);
          Get.to(() => OtpVerificationScreen(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          log("Auto Retrieval timeout");
        },
      );
    } else {
      Get.snackbar(
        'Invalid phone number format',
        'Please enter in E.164 format.',
      );
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp(String verificationId) async {
    isLoading(true);
    try {
      final cred = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(cred);
      Get.offAllNamed('/register');
    } catch (e) {
      log(e.toString());
      isLoading(false);
      Get.snackbar('OTP verification failed', 'Please try again.');
    } finally {
      isLoading(false);
    }
  }
}
