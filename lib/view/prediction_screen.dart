import 'dart:io';
import 'dart:math';
import 'package:dorothy/viewmodel/google_ads_vm.dart';
import 'package:dorothy/viewmodel/camera_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PredictionScreen extends StatelessWidget {
  final cameraVM = Get.find<CameraVM>();
  final ads = Get.find<ADS>();

  PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 화면 슬라이드로 뒤로 가기 제한
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Obx(
            () => cameraVM.isLoading.value
                ? Container() // 로딩 중일 때는 뒤로 가기 버튼을 비활성화
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
          ),

          title: const Text('사진 확인'),
          elevation: 0, // 그림자 제거
        ),
        // 이미지 좌우 반전
        body: Obx(
          () => Stack(
            // Stack 위젯으로 변경
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Image.file(
                        File(
                          cameraVM.image.value!.path,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 130.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.purple, width: 3.0),
                            ),
                            child: const Text(
                              '다시 찍기',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 155.w,
                          height: 50.h,
                          child: ElevatedButton(
                            // 로딩 시작 시 버튼 비활성화
                            onPressed: cameraVM.isLoading.value
                                ? null
                                : () async {
                                    cameraVM.isLoading.value = true;
                                    ads.interstitialAd?.show();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.purple, width: 3.0),
                            ),
                            child: const Text(
                              '결과 확인하기',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // 로딩 중 일때
              if (cameraVM.isLoading.value)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
