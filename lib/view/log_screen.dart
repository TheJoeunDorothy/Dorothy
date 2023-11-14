import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalHeader: AppBar(
        title: Text(Get.arguments.datetime),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: '공유하기',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      onChange: (index) {
        print('Current page: $index');
      },
      pages: getPages(),
      showSkipButton: false,
      showNextButton: false,
      showDoneButton: false,
    );
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "",
        bodyWidget: Text('퍼스널 컬러 결과 이미지'),
        image: Image.memory(
          base64Decode(Get.arguments.personalimage),
          fit: BoxFit.contain,
        ),
        decoration: const PageDecoration(
          imageFlex: 6,
          bodyFlex: 1,
          pageColor: Colors.white,
          bodyPadding: EdgeInsets.all(0),
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: Text('나이 예측 결과 이미지'),
        image: Image.memory(
          base64Decode(Get.arguments.ageimage),
          fit: BoxFit.contain,
        ),
        decoration: const PageDecoration(
          imageFlex: 6,
          bodyFlex: 1,
          pageColor: Colors.white,
          bodyPadding: EdgeInsets.all(0),
        ),
      ),
    ];
  }
}
