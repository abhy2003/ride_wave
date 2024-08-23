import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../controller/auth_controller.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;

  OtpVerificationScreen({required this.verificationId});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> with CodeAutoFill {
  final AuthController authController = Get.find<AuthController>();
  Timer? _timer;
  int _start = 60; // Initial countdown duration in seconds
  bool _isResendAvailable = false;

  @override
  void initState() {
    super.initState();
    listenForCode();
    _startTimer();
  }

  @override
  void codeUpdated() {
    setState(() {
      authController.otpController.text = code ?? '';
    });
    authController.verifyOtp(widget.verificationId);
  }

  void _startTimer() {
    _isResendAvailable = false;
    _start = 60; // Reset the timer duration
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start == 0) {
          _isResendAvailable = true;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  void _resendOtp() {
    // Resend the OTP
    authController.resendOtp();
    // Restart the timer
    _startTimer();
  }

  @override
  void dispose() {
    cancel();
    _timer?.cancel();
    super.dispose();
  }

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
            PinFieldAutoFill(
              controller: authController.otpController,
              codeLength: 6, // Assuming the OTP is 6 digits long
              decoration: UnderlineDecoration(
                textStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 20),
                colorBuilder: FixedColorBuilder(Colors.white54),
              ),
              currentCode: authController.otpController.text,
              onCodeSubmitted: (code) {
                authController.verifyOtp(widget.verificationId);
              },
            ),
            const SizedBox(height: 20),
            Obx(() => authController.isLoading.value
                ? Lottie.asset(
              'assets/images/lottie/loading.json',
              width: 70.0,
              height: 70.0,
              fit: BoxFit.fill,
            )
                : ElevatedButton(
              onPressed: () {
                authController.verifyOtp(widget.verificationId);
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
            const SizedBox(height: 20),
            TextButton(
              onPressed: _isResendAvailable ? _resendOtp : null,
              style: TextButton.styleFrom(
                foregroundColor: _isResendAvailable ? const Color(0xFFC5FF39) : Colors.grey,
              ),
              child: Text(
                _isResendAvailable ? "Resend OTP" : "Resend OTP in $_start seconds",
                style: TextStyle(
                  color: _isResendAvailable ? const Color(0xFFC5FF39) : Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
