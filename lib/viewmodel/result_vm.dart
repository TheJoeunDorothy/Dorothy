import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResultVM extends GetxController{
  var pageController = PageController();
  /// 페이지뷰 현재 페이지
  RxInt currentPage = 0.obs;
}