import 'dart:io';
import 'dart:math';
import 'package:dorothy/view/result_screen.dart';
import 'package:dorothy/viewmodel/result_vm.dart';
import 'package:dorothy/viewmodel/vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PredicrionScreen extends StatelessWidget {
  final VM vm = Get.find<VM>();

  PredicrionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => vm.isLoading.value
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
                        vm.image.value!.path,
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
                          onPressed: vm.isLoading.value
                              ? null
                              : () async {
                                  vm.isLoading.value = true;
                                  // 서버 통신 시간에 광고나, 로딩중 화면 띄어준 다음에 결과 페이지로 이동 해야됨
                                  try {
                                    vm.sendImage().then(
                                      (result) {
                                        if (result['result'] == null ||
                                            result['age'] == null ||
                                            result['percent'] == null) {
                                          _predDialog(context);
                                        } else {
                                          ResultVM controller =
                                              Get.put(ResultVM());
                                          controller.result = result;
                                          controller.originalImage =
                                              vm.base64Image;
                                          vm.insertLogs();
                                          Get.off(() => const ResultScreen());
                                        }
                                        // 로딩 종료
                                        vm.isLoading.value = false;
                                      },
                                    );
                                  } catch (e) {
                                    // 로딩 종료
                                    _predDialog(context);
                                    vm.isLoading.value = false;
                                  }
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // 로딩 중 일때 -> 광고로 전환 예정
            if (vm.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> _predDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // ScreenUtil 초기화
      ScreenUtil screenUtil = ScreenUtil();

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 다이얼로그의 모서리를 둥글게 만듭니다.
        ),
        title: Text(
          '오류가 발생했어요.\n사진을 다시 찍어주세요.',
          style: TextStyle(
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.center, // 텍스트를 중앙 정렬합니다.
        ),
        actions: <Widget>[
          SizedBox(
            width: screenUtil.screenWidth,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 버튼의 모서리를 둥글게 만듭니다.
                ),
              ),
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text(
                "사진 다시 찍으러 가기",
                style: TextStyle(
                  fontSize: 18.sp, // 버튼 텍스트의 크기를 조절합니다.
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
