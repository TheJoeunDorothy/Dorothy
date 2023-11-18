import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dorothy/static/personal_color.dart';
import 'package:dorothy/viewmodel/result_vm.dart';
import 'package:dorothy/widget/age_result.dart';
import 'package:dorothy/widget/color_result.dart';
import 'package:dorothy/widget/info_slider_indicator.dart';
import 'package:dorothy/widget/slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final resultVM = Get.find<ResultVM>();
  static final GlobalKey<_ResultScreenState> key = GlobalKey<_ResultScreenState>();
  late final Color backgroundColor;
  late final Color foregroundColor;
  late final String imagePath;

  @override
  void initState() {
    super.initState();
    String colorResult = resultVM.result['result'];
    imagePath = resultVM.changeThemeWithResult(colorResult)['imagePath'];
    SeasonTheme theme = resultVM.changeThemeWithResult(colorResult)['theme'];
    backgroundColor = theme.backgroundColor;
    foregroundColor = theme.foregroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('result_appbar'.tr, style: TextStyle(color: foregroundColor),),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RepaintBoundary(
              key: key,
              child: Container(
                color: backgroundColor,
                child: sliderWidget(
                  pageHeight: 590.h,
                  vm: resultVM,
                  firstWidget: colorResult(context, resultVM.originalImage, resultVM.result, imagePath, foregroundColor, backgroundColor),
                  secondWidget: ageResult(context, resultVM.originalImage, resultVM.result, foregroundColor, backgroundColor),
                  textColor: foregroundColor, 
                  primaryColor: backgroundColor
                ),
              ),
            ),
            sliderIndicator(resultVM),
            SizedBox(
              width: 230.w,
              child: CupertinoButton(
                color: foregroundColor,
                onPressed: () async {
                  Uint8List? resultImageByte = await captureImage(key: key);
                  shareImage(resultImageByte);
                },
                child: Text(
                  'share_button'.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> captureImage({required key}) async {
    try {
      // 캡처할 위젯의 키 저장
      GlobalKey globalKey = key;
      // 캡처할 범위 찾아오기
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      // 범위를 이미지로 변환
      var image = await boundary.toImage(pixelRatio: 5.0); // 이미지 화질 설정
      // 이미지를 byte 형태로 변환
      ByteData byteData =
          (await image.toByteData(format: ImageByteFormat.png))!;

      return byteData.buffer.asUint8List();
    } catch (e) {
      //print('error captureImage: $e');
      return null;
    }
  }

  /// 결과 이미지 공유하기 기능
  /// 
  /// @params : `Uint8List?`
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
      Share.shareXFiles(
        [XFile(file.path)], 
        text: (resultVM.currentPage.value == 0) ? 'share_face_message'.tr : 'share_color_message',
      );
    } catch (e) {
      //print('Error sharing image: $e');
    }
  }
}
