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
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                    ),
                    onPressed: () => Get.back(),
                  ),
          ),
          title: Text(
            'prediction_appbar'.tr,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black, size: 24),
        ),
        body: Obx(
          () => Stack(
            // Stack 위젯으로 변경
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    // 이미지 좌우 반전, 밝기 조절
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.3),
                          BlendMode.softLight,
                        ),
                        child: Image.file(
                          File(
                            cameraVM.image.value!.path,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
              ),
              // 로딩 중 일때
              if (cameraVM.isLoading.value)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          height: 150.h,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140.w,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: Colors.purple,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      'picture_again_button'.tr,
                      style: const TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                SizedBox(
                  width: 200.w,
                  height: 55.h,
                  child: ElevatedButton(
                    // 로딩 시작 시 버튼 비활성화
                    onPressed: cameraVM.isLoading.value
                        ? null
                        : () async {
                            cameraVM.isLoading.value = true;
                            if (ads.isAdFrontLoaded.value) {
                              ads.interstitialAd?.show();
                            } else {
                              Map<String, dynamic>? result =
                                  await cameraVM.sendImage();
                              ads.handleResult(result, cameraVM);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.purple,
                    ),

                    child: Text(
                      'check_result_button'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
