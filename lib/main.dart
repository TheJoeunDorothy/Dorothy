import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dorothy/model/logs_handler.dart';
import 'package:dorothy/services/translation_service.dart';
import 'package:dorothy/static/assets_image.dart';
import 'package:dorothy/view/camera_screen.dart';
import 'package:dorothy/view/onboarding_screen.dart';
import 'package:dorothy/viewmodel/google_ads_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // main 함수 비동기 처리 위해서 꼭 적어야 함.
  WidgetsFlutterBinding.ensureInitialized();
  // landscpae 막기
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  // 광고 초기화
  MobileAds.instance.initialize();
  // .env 파일 로드
  await dotenv.load();
  // 광고 컨트롤러
  Get.put(ADS());
  await LogsHandler().initalaizeDB(); // LOG용 SQLite 로드
  // 온보딩 페이지 기본값 false
  bool hasSeenOnboarding = await _getOnboardingState();

  // 권한 상태에 따라 화면 결정
  Widget initialScreen =
      (!hasSeenOnboarding) ? const OnBoardingScreen() : CameraScreen();

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
          title: 'Dorothy',
          debugShowCheckedModeBanner: false,
          // 기기의 폰트사이즈를 따라가지 않고 고정
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },
          // 지역 설정
          locale: Get.deviceLocale,
          // 번역 서비스
          translations: TranslationService(),
          // 지원하지 않는 언어일 때의 locale
          fallbackLocale: const Locale('ko', 'KR'),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
              titleMedium: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                titleTextStyle: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            dialogTheme: DialogTheme(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                )),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: AnimatedSplashScreen(
            splashIconSize: 400.h,
            splash: Image.asset(
              AssetsImage.SPLASH_IMAGE,
            ),
            nextScreen: initialScreen,
            // backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

Future<bool> _getOnboardingState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  return hasSeenOnboarding;
}
