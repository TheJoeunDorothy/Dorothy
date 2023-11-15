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
        title: const Text('사진 확인'),
        elevation: 0, // 그림자 제거
      ),
      // 이미지 좌우 반전
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.5, // 50% of screen height
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
                      side: const BorderSide(color: Colors.purple, width: 3.0),
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
                    onPressed: () async {
                      // 서버 통신 시간에 광고나, 로딩중 화면 띄어준 다음에 결과 페이지로 이동 해야됨
                      vm.sendImage().then(
                        (result) {
                          if (result['result'] == null ||
                              result['age'] == null ||
                              result['percent'] == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '오류가 발생했어요. 사진을 다시 찍어주세요.',
                                      ),
                                    ),
                                  ],
                                ),
                                duration: const Duration(seconds: 1),
                                width: 310.w,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            );
                          } else {
                            Get.off(() => const ResultScreen());
                            ResultVM controller = Get.put(ResultVM());
                            controller.result = result;
                            controller.originalImage = vm.base64Image;
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.purple, width: 3.0),
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
    );
  }
}
