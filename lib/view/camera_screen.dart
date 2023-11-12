import 'package:camera/camera.dart';
import 'package:dorothy/view/prediction_screen.dart';
import 'package:dorothy/view/settings_screen.dart';
import 'package:dorothy/viewmodel/vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatelessWidget {
  final VM vm = Get.put(VM());

  CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 제한
        actions: [
          IconButton(
            onPressed: () => Get.defaultDialog(
              backgroundColor: Colors.white,
              title: '설명창',
              actions: [
                CupertinoButton.filled(
                  child: const Text('확인'),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            icon: const Icon(Icons.info_outlined),
          ),
          IconButton(
            onPressed: () async {
              vm.isPageStreaming.value = false;
              await Get.to(
                const SettingsScreen(),
              )?.then(
                (value) => vm.isPageStreaming.value = true,
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: (!vm.cameraState.value || !vm.microphoneState.value)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '필수 권한을 허용해 주세요',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CupertinoButton.filled(
                      child: const Text('권한 허용하기'),
                      onPressed: () async => await openAppSettings(),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  Obx(
                    () {
                      // 컨트롤러가 초기화가 되지 않았다면 인디케이터를 띄어줌
                      if (vm.controller.value == null ||
                          !vm.controller.value!.value.isInitialized) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Positioned.fill(
                          child: AspectRatio(
                            aspectRatio: vm.controller.value!.value.aspectRatio,
                            child: CameraPreview(vm.controller.value!),
                          ),
                        );
                      }
                    },
                  ),
                  Center(
                    child: Obx(
                      () => Container(
                        width: 230.w, // 사람 얼굴 사이즈에 맞게 조정
                        height: 300.h, // 사람 얼굴 사이즈에 맞게 조정
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle, // 모서리 틀로 변경
                          border: Border.all(color: vm.myColor.value, width: 5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // 촬영 버튼
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 230.h,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 카메라 촬영시 예측 페이지
              SizedBox(
                width: 75.w,
                height: 75.h,
                child: Obx(
                  () => FloatingActionButton(
                    onPressed: vm.myColor.value == Colors.amber
                        ? () async {
                            // 사진 찍기
                            await vm.takePicture();
                            // 이미지 서버 전달 이쪽!!!!

                            // 스트리밍 종료
                            vm.isPageStreaming.value = false;
                            // 다음 페이지로 이동하고, 찍은 사진을 전달
                            Get.to(
                              PredicrionScreen(),
                            )?.then((value) => vm.isPageStreaming.value = true);
                          }
                        : null,
                    backgroundColor: Colors.white,
                    foregroundColor: vm.myColor.value,
                    elevation: 0,
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    child: const Icon(Icons.photo_camera),
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
