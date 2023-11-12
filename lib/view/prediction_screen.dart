import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PredicrionScreen extends StatelessWidget {
  final XFile image;

  const PredicrionScreen({super.key, required this.image});

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
        child: Image.file(File(image.path)),
      ),
    );
  }
}
