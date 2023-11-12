import 'package:dorothy/view/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: '',
        body: '당신의 얼굴을 분석하여 나이를 예측해보세요.',
        image: Center(
          child: Image.asset(
            "assets/images/face_age.jpeg",
            width: 450.w,
            height: 500.h,
          ),
        ),
        //getPageDecoration, a method to customise the page style
        decoration: const PageDecoration(
          imagePadding: EdgeInsets.only(top: 120),
          pageColor: Colors.white,
          bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
          titlePadding: EdgeInsets.only(top: 50),
          bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
      PageViewModel(
        title: '',
        body: '당신의 얼굴을 분석하여 가장 잘 어울리는 컬러를 찾아보세요.',
        image: Center(
          child: Image.asset(
            "assets/images/personal_color.jpeg",
            width: 450.w,
            height: 500.h,
          ),
        ),
        //getPageDecoration, a method to customise the page style
        decoration: const PageDecoration(
          imagePadding: EdgeInsets.only(top: 120),
          pageColor: Colors.white,
          bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
          titlePadding: EdgeInsets.only(top: 50),
          bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
      PageViewModel(
        title: '',
        body: '당신의 얼굴을 카메라로 찍어보세요. 얼굴을 인식하여 분석을 시작합니다.',
        image: Center(
          child: Image.asset(
            "assets/images/face_recognition.jpeg",
            width: 450.w,
            height: 500.h,
          ),
        ),
        //getPageDecoration, a method to customise the page style
        decoration: const PageDecoration(
          imagePadding: EdgeInsets.only(top: 120),
          pageColor: Colors.white,
          bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
          titlePadding: EdgeInsets.only(top: 50),
          bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalHeader: PreferredSize(
        preferredSize: const Size.fromHeight(0.0), // 0으로 설정하여 앱바를 숨김
        child: AppBar(
          elevation: 0, // 그림자 제거
        ),
      ),
      pages: getPages(),
      showNextButton: true,
      next: const Icon(Icons.arrow_forward),
      done: const Text("시작하기", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () async {
        // 온보딩 페이지를 보았다는 정보를 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenOnboarding', false);

        // 권한 설정 화면으로 이동
        Get.offAll(() => const PermissionScreen());
      },
    );
  }
}
