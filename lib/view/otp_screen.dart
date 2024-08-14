import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final bool isRegisteredNumber;

  const OtpVerificationScreen({
    Key? key,
    required this.verificationId,
    required this.isRegisteredNumber,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  List<String> otpDigits = ['', '', '', '', '', ''];
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Ride Wave logo-02.png', height: 150),
            const SizedBox(height: 25),
            const Text(
              'Mobile Verification',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter OTP here',
              style: TextStyle(fontSize: 12, color: Colors.white54),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 6; i++)
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      focusNode: _focusNodes[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorColor: Colors.white54,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        if (value.isNotEmpty && i < 5) {
                          _focusNodes[i + 1].requestFocus();
                        }
                        setState(() {
                          otpDigits[i] = value;
                        });
                      },
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Handle resend OTP here
              },
              child: const Text(
                "Didn't receive the code? RESEND",
                style: TextStyle(
                  color: Colors.white54,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final enteredOtp = otpDigits.join();

                if (enteredOtp.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter the OTP')),
                  );
                  return;
                }

                try {
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: enteredOtp,
                  );

                  await FirebaseAuth.instance.signInWithCredential(credential);

                  if (widget.isRegisteredNumber) {
                    Get.offNamed('/homescreen');
                  } else {
                    Get.offNamed('/register');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid OTP: ${e.toString()}')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC5FF39),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Verify Now',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
