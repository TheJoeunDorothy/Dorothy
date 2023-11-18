import 'package:dorothy/model/logs_handler.dart';
import 'package:dorothy/static/assets_image.dart';
import 'package:dorothy/static/personal_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultVM extends GetxController {
  late LogsHandler handler;
  PageController pageController = PageController();
  late Map<String, dynamic> result;
  late String originalImage;

  /// 페이지뷰 현재 페이지
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    handler = LogsHandler();
  }

  /// 퍼스널컬러 결과에 따른 테마 색 변경 함수.
  Map<String, dynamic> changeThemeWithResult(String colorResult) {
    SeasonTheme theme;
    String imagePath = '';
    switch (colorResult) {
      case '봄웜톤':
        theme = SeasonTheme.spring;
        imagePath = AssetsImage.SPRING_IMAGE;
        break;
      case '여름쿨톤':
        theme = SeasonTheme.summer;
        imagePath = AssetsImage.SUMMER_IMAGE;
        break;
      case '가을웜톤':
        theme = SeasonTheme.autumn;
        imagePath = AssetsImage.AUTUMN_IMAGE;
        break;
      case '겨울쿨톤':
        theme = SeasonTheme.winter;
        imagePath = AssetsImage.WINTER_IMAGE;
        break;
      default:
        theme = SeasonTheme.spring;
        imagePath = AssetsImage.SPRING_IMAGE;
        break;
    }
    return {'theme':theme, 'imagePath':imagePath};
  }

}
