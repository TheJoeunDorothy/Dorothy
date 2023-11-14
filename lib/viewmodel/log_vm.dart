import 'dart:convert';
import 'dart:io';

import 'package:dorothy/model/logs.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class LogVm extends GetxController{
  Rx<Logs> log = Logs().obs;
  RxString nowImage = ''.obs;


  void shareImage(String? imageBytes) async {
    try {
      if (imageBytes == null) {
        return;
      }
      // 이미지를 저장할 임시 디렉토리 가져오기
      final tempDir = await getTemporaryDirectory();
      // 이미지 파일로 저장
      final file =
          await File('${tempDir.path}/image.png').writeAsBytes(base64Decode(imageBytes));

      // share 패키지를 사용하여 이미지 파일을 공유
      Share.shareFiles([file.path]);
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
}