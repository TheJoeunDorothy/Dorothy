import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dorothy/static/personal_color.dart';
import 'package:dorothy/viewmodel/result_vm.dart';
import 'package:dorothy/widget/info_slider_indicator.dart';
import 'package:dorothy/widget/result_slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final vm = Get.find<ResultVM>();
  Color backgroundColor = Colors.white; // 배경색

  @override
  void initState() {
    super.initState();
    initializeResultScreen();
  }

  initializeResultScreen() async {
    // 결과 받아오기
    String colorResult = vm.result['result'];
    // 결과에 따른 배경색 설정
    switch (colorResult) {
      case '봄웜톤':
        backgroundColor = PersonalColor.springColor;
        break;
      case '여름쿨톤':
        backgroundColor = PersonalColor.summerColor;
        break;
      case '가을웜톤':
        backgroundColor = PersonalColor.autumnColor;
        break;
      case '겨울쿨톤':
        backgroundColor = PersonalColor.winterColor;
        break;
      default:
        backgroundColor = Colors.white;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('예측 결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RepaintBoundary(
              key: vm.key,
              child: resultSliderWidget(vm),
            ),
            infoSliderIndicator(vm),
            CupertinoButton.filled(
              onPressed: () async {
                Uint8List? resultImageByte = await captureImage(key: vm.key);
                shareImage(resultImageByte);
              },
              child: const Text('공유하기'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> captureImage({required key}) async {
    try {
      // 캡처할 위젯의 키
      GlobalKey gKey = key;
      // 캡처할 범위 찾아오기
      RenderRepaintBoundary boundary =
          gKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      // 범위를 이미지로 변환
      var image = await boundary.toImage(pixelRatio: 5.0); // 이미지 화질 설정
      // 이미지를 byte 형태로 변환
      ByteData byteData =
          (await image.toByteData(format: ImageByteFormat.png))!;
      return byteData.buffer.asUint8List();
    } catch (e) {
      print('error captureImage: $e');
      return null;
    }
  }

  /// 결과 이미지 2개 공유하기
  void shareImage(Uint8List? imageBytes) async {
    try {
      if (imageBytes == null) {
        return;
      }
      // 이미지를 저장할 임시 디렉토리 가져오기
      final tempDir = await getTemporaryDirectory();
      // 이미지 파일로 저장
      File file =
          await File('${tempDir.path}/image.png').writeAsBytes(imageBytes);

      // share 패키지를 사용하여 이미지 파일을 공유
      Share.shareFiles([file.path]);
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
}
