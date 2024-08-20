import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controller/auth_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String verificationId;
  final AuthController authController = Get.find<AuthController>();

  OtpVerificationScreen({required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "We have sent an OTP to your phone. Please verify.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white54),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: authController.otpController,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white54,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.25),
                filled: true,
                hintText: "Enter OTP",
                hintStyle: GoogleFonts.poppins(color: Colors.white54),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white54),
                ),
              ),
              style: GoogleFonts.poppins(color: Colors.white54),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 20),
            Obx(() => authController.isLoading.value
                ? Lottie.asset(
                    'assets/images/lottie/loading.json',
                    // Replace with the path to your Lottie file
                    width: 70.0,
                    height: 70.0,
                    fit: BoxFit.fill,
                  )
                : ElevatedButton(
                    onPressed: () {
                      authController.verifyOtp(verificationId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC5FF39),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
