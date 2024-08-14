import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/home_screen.dart';

class OTPController extends GetxController {
  final otpController = TextEditingController();
  var isLoading = false.obs;

  void verifyOTP(String verificationId) async {
    String otp = otpController.text.trim();

    if (otp.isNotEmpty) {
      isLoading.value = true;

      try {
        final cred = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        );
        await FirebaseAuth.instance.signInWithCredential(cred);
        Get.off(() => HomeScreen());
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'Verification failed. Please try again.');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Please enter the OTP.');
    }
  }
}
