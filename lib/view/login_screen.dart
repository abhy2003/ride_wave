import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // Function to validate the phone number format
  bool validatePhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^\+[1-9]\d{1,14}$');
    return regex.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Ride Wave logo-02.png', height: 200.h),
              TextFormField(
                cursorColor: Colors.white54,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white54,
                  ),
                  prefixIcon: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '+91 ',
                          style: GoogleFonts.poppins(color: Colors.white54),
                        ),
                        TextSpan(
                          text: '',
                          style: GoogleFonts.poppins(
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.white54,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone field can't be empty";
                  }

                  final pattern = r'^[6-9]\d{9}$';
                  final regex = RegExp(pattern);

                  if (!regex.hasMatch(value)) {
                    return "Enter a valid 10-digit phone number starting with 6, 7, 8, or 9";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String phoneNumber = '+91' + _phoneController.text.trim();

                    if (validatePhoneNumber(phoneNumber)) {
                      setState(() {
                        isLoading = true;
                      });

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneNumber,
                        verificationCompleted: (PhoneAuthCredential credential) async {
                          // This callback is called when the verification is automatically completed
                          try {
                            await FirebaseAuth.instance.signInWithCredential(credential);
                            Get.offNamed('/homescreen');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign-in failed: ${e.toString()}')),
                            );
                          }
                        },
                        verificationFailed: (FirebaseAuthException error) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Verification failed: ${error.message}'),
                            ),
                          );
                          log('Verification failed: ${error.message}');
                        },
                        codeSent: (String verificationId, int? forceResendingToken) {
                          setState(() {
                            isLoading = false;
                          });
                          Get.toNamed('/otpverification', arguments: {
                            'verificationId': verificationId,
                            'isRegisteredNumber': true,
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          log("Auto Retrieval timeout: $verificationId");
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid phone number format. Please enter in E.164 format.'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC5FF39),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Login Now',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}