import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

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
                controller: authController.phoneController,
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.verifyPhoneNumber(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC5FF39),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
