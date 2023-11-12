import 'dart:io';
import 'dart:math';
import 'package:dorothy/viewmodel/vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PredicrionScreen extends StatelessWidget {
  final VM vm = Get.find<VM>();

  PredicrionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('찍은 사진'),
      ),
      // 이미지 좌우 반전
      body: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Image.file(
          File(
            vm.image.value!.path,
          ),
        ),
      ),
    );
  }
}
