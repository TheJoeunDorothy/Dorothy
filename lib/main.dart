import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dorothy/view/camera_screen.dart';
import 'package:dorothy/view/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // main 함수 비동기 처리 위해서 꼭 적어야 함.
  WidgetsFlutterBinding.ensureInitialized();

  // 권한설정 페이지를 한 번이라도 들어갔으면 true로 저장되어있음.
  bool isFirstAppRun = await _getFirstAppRunState();
  // 권한 확인

  // 권한 상태에 따라 화면 결정
  Widget initialScreen =
      (isFirstAppRun) ? const PermissionScreen() : CameraScreen();

  runApp(MyApp(
    initialScreen: initialScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iphone 13 & 14 사이즈.
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
            nextScreen: initialScreen,
            // backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

Future<bool> _getFirstAppRunState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool permissionState = prefs.getBool('permissionState') ?? true;
  return permissionState;
}
