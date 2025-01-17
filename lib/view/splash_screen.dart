import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/car.jpg',
              fit: BoxFit.cover, // Ensure the image covers the entire screen
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Positioned(
            top: 32.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/Ride Wave logo-02.png',
                  height: 80.h,
                  width: 80.w,
                ),
                TextButton(
                  onPressed: () {
                    Get.offNamed('/login'); // Use GetX to navigate
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 160.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Book a cab online with ease!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Book a cab in seconds and enjoy a smooth ride',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32.h,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/login'); // Use GetX to navigate
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFC5FF39),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 30.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
