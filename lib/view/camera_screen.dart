import 'package:camera/camera.dart';
import 'package:dorothy/view/prediction_screen.dart';
import 'package:dorothy/view/settings_screen.dart';
import 'package:dorothy/viewmodel/camera_vm.dart';
import 'package:dorothy/widget/google_ads_widget.dart';
import 'package:dorothy/widget/info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatelessWidget {
  final cameraVM = Get.put(CameraVM());

  CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(107),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const AdBanner(),
            SizedBox(
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      await Get.dialog(infoDialog());
                      cameraVM.resetInfoPage();
                    },
                    icon: const Icon(Icons.info_outlined),
                  ),
                  IconButton(
                    onPressed: () async {
                      cameraVM.isPageStreaming.value = false;
                      await Get.to(
                        () => const SettingsScreen(),
                      )?.then(
                        (value) => cameraVM.isPageStreaming.value = true,
                      );
                    },
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: (!cameraVM.isAllPermissionAllowed.value)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'camera_permission_text'.tr,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CupertinoButton.filled(
                        child: Text('permission_button'.tr),
                        onPressed: () async => await openAppSettings(),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    // 컨트롤러가 초기화가 되지 않았다면 인디케이터를 띄어줌
                    if (cameraVM.controller.value == null ||
                        !cameraVM.controller.value!.value.isInitialized)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Positioned.fill(
                        bottom: 3.0,
                        child: AspectRatio(
                          aspectRatio:
                              cameraVM.controller.value!.value.aspectRatio,
                          child: CameraPreview(cameraVM.controller.value!),
                        ),
                      ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2 -
                          370.h, // 텍스트 위치 조절
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          cameraVM.myColor.value == Colors.purple
                              ? "camera_face_recognition_text_1".tr
                              : "camera_face_recognition_text_2".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: Colors.white,
                            shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.3, 0.3),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 230.w, // 사람 얼굴 사이즈에 맞게 조정
                        height: 300.h, // 사람 얼굴 사이즈에 맞게 조정
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle, // 모서리 틀로 변경
                          border: Border.all(
                              color: cameraVM.myColor.value, width: 5),
                          borderRadius: BorderRadius.circular(150),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      // 촬영 버튼
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 150.h,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 카메라 촬영시 예측 페이지
              SizedBox(
                width: 75.w,
                height: 75.h,
                child: Obx(
                  () => FloatingActionButton(
                    onPressed: cameraVM.myColor.value == Colors.purple
                        ? () async {
                            // 사진 찍기
                            bool success = await cameraVM.takePicture(context);
                            if (!success) {
                              return;
                            }
                            // 스트리밍 종료
                            cameraVM.isPageStreaming.value = false;
                            // 다시 카메라 화면으로 돌아왔을때 이미지 스트리밍 활성
                            Get.to(
                              () => PredictionScreen(),
                            )?.then((value) =>
                                cameraVM.isPageStreaming.value = true);
                          }
                        : null,
                    backgroundColor: Colors.white,
                    foregroundColor: cameraVM.myColor.value,
                    elevation: 0,
                    shape: CircleBorder(
                      side: BorderSide(
                          color: cameraVM.myColor.value == Colors.purple
                              ? cameraVM.myColor.value
                              : Colors.black,
                          width: 5.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
