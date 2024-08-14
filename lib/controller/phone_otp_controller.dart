import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/phone_model.dart';
import '../views/otp_screen.dart';

class PhoneController extends GetxController {
  final phoneController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void validateAndSubmitPhoneNumber() async {
    String phoneNumber = '+91' + phoneController.text.trim();

    if (validatePhoneNumber(phoneNumber)) {
      isLoading.value = true;
      errorMessage.value = '';

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          // Handle auto verification if needed
        },
        verificationFailed: (error) {
          isLoading.value = false;
          errorMessage.value = 'Verification failed: ${error.message}';
          Get.snackbar('Error', errorMessage.value);
        },
        codeSent: (verificationId, forceResendingToken) {
          isLoading.value = false;
          Get.to(() => OTPScreen(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          // Handle auto retrieval timeout
        },
      );
    } else {
      Get.snackbar('Invalid Phone Number', 'Please enter in E.164 format.');
    }
  }

  bool validatePhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^\+[1-9]\d{1,14}$');
    return regex.hasMatch(phoneNumber);
  }
}
