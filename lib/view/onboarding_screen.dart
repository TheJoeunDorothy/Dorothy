import 'package:dorothy/static/assets_image.dart';
import 'package:dorothy/view/permission_screen.dart';
import 'package:dorothy/widget/pageview_onbarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  List<PageViewModel> getPages(BuildContext context) {
    return [
      buildPage(context, AssetsImage.ONBOARDING_AGE, "onboarding_title_1".tr,
          'onboarding_subtitle_1'.tr),
      buildPage(context, AssetsImage.ONBOARDING_COLOR, "onboarding_title_2".tr,
          'onboarding_subtitle_1'.tr),
      buildPage(context, AssetsImage.ONBOARDING_FACE_RECOGNITION,
          "onboarding_title_3".tr, 'onboarding_subtitle_1'.tr),
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
        done: Text("onboarding_done".tr,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 17.sp)),
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
