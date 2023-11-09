import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dorothy/view/camera_screen.dart';
import 'package:dorothy/view/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  // main 함수 비동기 처리 위해서 꼭 적어야 함.
  WidgetsFlutterBinding.ensureInitialized();
  // 권한 확인
  bool isCameraPermissionGranted = await isPermissionPermitted(Permission.camera);
  bool isPhotosPermissionGranted = await isPermissionPermitted(Permission.photos);

  // 권한 상태에 따라 화면 결정
  Widget initialScreen;
  if (isCameraPermissionGranted && isPhotosPermissionGranted) {
    initialScreen = const CameraScreen();
  } else {
    initialScreen = const PermissionScreen();
  }
  runApp( MyApp(initialScreen: initialScreen,));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iphone 13 & 14 사이즈.
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
            nextScreen: initialScreen,
            // backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

Future<bool> isPermissionPermitted(Permission permission) async {
    var status = await permission.status;
    return status.isGranted;
  }
