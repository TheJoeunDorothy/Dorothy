import 'package:dorothy/view/permission_screen.dart';
import 'package:dorothy/widget/pageview_onbarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  List<PageViewModel> getPages(BuildContext context) {
    return [
      buildPage(context, "assets/images/face_age.jpeg", "얼굴 나이 분석",
          '당신의 얼굴을 분석하여\n나이를 예측해보세요.'),
      buildPage(context, "assets/images/personal_color.jpeg", "퍼스널 컬러 분석",
          '당신의 얼굴을 분석하여\n가장 잘 어울리는 컬러를 찾아보세요.'),
      buildPage(context, "assets/images/face_recognition.jpeg", "얼굴 인식 AI",
          '당신의 얼굴을 카메라로 찍어보세요.\n얼굴을 인식하여 분석을 시작합니다.'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: getPages(context),
        showNextButton: true,
        next: const Icon(Icons.arrow_forward_ios, color: Colors.black),
        done: const Text("시작하기",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
        onDone: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('hasSeenOnboarding', true);
          Get.offAll(() => const PermissionScreen());
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          activeColor: Colors.blue,
          color: Colors.grey,
        ),
      ),
    );
  }
}
