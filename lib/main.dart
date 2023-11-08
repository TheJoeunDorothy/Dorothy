import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dorothy/view/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iphone 13 & 14
      minTextAdapt: true,
      splitScreenMode: true, // 분할 모드 지원
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: AnimatedSplashScreen(
            splashIconSize: 400.h,
            splash: Image.asset(
              'assets/images/Dorothy.gif',
            ),
            nextScreen: const CameraScreen(),
            // backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
