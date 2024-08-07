import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_wave/view/login_screen.dart';
import 'package:ride_wave/view/otp_screen.dart';
import 'package:ride_wave/view/register.dart';
import 'package:ride_wave/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/otpverification', page: () => const OtpVerificationScreen(isRegisteredNumber: false)),
          GetPage(name: '/register', page: () => const Register()),
          GetPage(name: '/homescreen', page: () => const Homes()),
        ],
      ),
    );
  }
}
