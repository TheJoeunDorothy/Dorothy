import 'package:dorothy/model/logs.dart';
import 'package:dorothy/model/logs_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResultVM extends GetxController{
  late LogsHandler handler;
  var pageController = PageController();
  late Map<String, dynamic> result;
  late String originalImage;
  /// 페이지뷰 현재 페이지
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    handler = LogsHandler();
  }

}