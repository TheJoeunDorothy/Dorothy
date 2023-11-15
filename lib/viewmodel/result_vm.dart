import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResultVM extends GetxController{
  var pageController = PageController();
  late Map<String, dynamic> result;
  late String originalImage;
  /// 페이지뷰 현재 페이지
  RxInt currentPage = 0.obs;
}