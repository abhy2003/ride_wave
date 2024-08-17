import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_wave/controller/banner_image_controller.dart'; // Example controller
import 'package:ride_wave/view/home_screen.dart';
import 'package:ride_wave/view/login_screen.dart';
import 'package:ride_wave/view/otp_verification_screen.dart';
import 'package:ride_wave/view/register.dart';
import 'package:ride_wave/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
        theme: ThemeData(
          // Your custom theme data here
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/register', page: () => const Register()),
          GetPage(name: '/homescreen', page: () =>  HomeScreen()),
        ],
      ),
    );
  }
}
