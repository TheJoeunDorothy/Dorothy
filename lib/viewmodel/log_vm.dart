import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dorothy/model/logs.dart';
import 'package:dorothy/static/personal_color.dart';
import 'package:dorothy/viewmodel/result_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// LogScreen을 위한 Controller
class LogVM extends GetxController {
  late Logs log;
  var pageController = PageController();
  var resultVM = ResultVM();
  late Color backgroundColor;
  late Color foregroundColor;

  RxInt currentPage = 0.obs;
  late Map<String, dynamic> result;
  late String originalImage;

  LogVM({required this.log});

  @override
  void onInit() {
    super.onInit();
    originalImage = log.originalImage;
    result = {
      'result': log.colorResult,
      'age': log.ageResult,
      'percent': [
        log.onePercent,
        log.twoPercent,
        log.threePercent,
        log.fourPercent,
        log.fivePercent,
        log.sixPercent,
        log.sevenPercent,
      ]
    };
    // resultSliderWidget 에 종속 되어있는 초기화
    String colorResult = result['result'];
    SeasonTheme theme = resultVM.changeThemeWithResult(colorResult);
    backgroundColor = theme.backgroundColor;
    foregroundColor = theme.foregroundColor;
  }

  Future<Uint8List?> captureImage({required key}) async {
    try {
      // 캡처할 범위 찾아오기
      RenderRepaintBoundary boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary;
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
  /// image 를 받아서, 공유하기
  /// @params : `String[Base64]`
  void shareImage(Uint8List? imageBytes) async {
    try {
      if (imageBytes == null) {
        return;
      }
      // 이미지를 저장할 임시 디렉토리 가져오기
      final tempDir = await getTemporaryDirectory();
      // 이미지 파일로 저장
      File file = await File('${tempDir.path}/result_image.png').writeAsBytes(imageBytes);
      // share 패키지를 사용하여 이미지 파일을 공유
      Share.shareXFiles([XFile(file.path)]);
    } catch (e) {
      //print('Error sharing image: $e');
    }
  }
}
