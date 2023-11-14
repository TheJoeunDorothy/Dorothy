import 'dart:io';
import 'dart:math';
import 'package:dorothy/view/result_screen.dart';
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
                      vm.sendImage().then((result) {
                        Get.off(const ResultScreen(), arguments: result);
                        // 결과 출력
                        print('Result: ${result['result']}');
                        print('Age: ${result['age']}');
                        print('Percent: ${result['percent']}');
                      });
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
