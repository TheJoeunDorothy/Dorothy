import 'package:dorothy/view/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Image.asset('assets/images/face_age.jpeg'),
        title: "Face Age",
        body: "당신의 얼굴을 분석하여 나이를 예측해보세요.",
        footer: const Text("임시"),
      ),
      PageViewModel(
        image: Image.asset('assets/images/personal_color.jpeg'),
        title: "personal_color",
        body: "당신의 얼굴을 분석하여 가장 잘 어울리는 컬러를 찾아보세요.",
        footer: const Text("임시"),
      ),
      PageViewModel(
        image: Image.asset('assets/images/face_recognition.jpeg'),
        title: "face_recognition",
        body: "당신의 얼굴을 카메라로 찍어보세요. 얼굴을 인식하여 분석을 시작합니다.",
        footer: const Text("임시"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(),
      showNextButton: true,
      next: const Icon(Icons.arrow_forward),
      done: const Text("시작하기", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () async {
        // 온보딩 페이지를 보았다는 정보를 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenOnboarding', true);

        // 권한 설정 화면으로 이동
        Get.offAll(() => const PermissionScreen());
      },
    );
  }
}
