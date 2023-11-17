import 'dart:typed_data';
import 'package:dorothy/viewmodel/log_vm.dart';
import 'package:dorothy/widget/age_result.dart';
import 'package:dorothy/widget/color_result.dart';
import 'package:dorothy/widget/info_slider_indicator.dart';
import 'package:dorothy/widget/slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final vm = Get.find<LogVM>();
  GlobalKey<_LogScreenState> key = GlobalKey<_LogScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: vm.backgroundColor,
        title: Text(
          'log_button'.tr,
          style:
              TextStyle(color: vm.foregroundColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
           color: vm.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RepaintBoundary(
                key: key,
                child: Container(
                  color: vm.backgroundColor,
                  child: sliderWidget(
                      pageHeight: 590.h,
                      vm: vm,
                      firstWidget: ageResult(context, vm.originalImage, vm.result,
                          vm.foregroundColor, vm.backgroundColor),
                      secondWidget: colorResult(context, vm.originalImage,
                          vm.result, vm.foregroundColor, vm.backgroundColor),
                      textColor: vm.foregroundColor,
                      primaryColor: vm.backgroundColor),
                ),
              ),
              sliderIndicator(vm),
              SizedBox(
              width: 230.w,
              child: CupertinoButton(
                color: vm.foregroundColor,
                onPressed: () async {
                  Uint8List? resultImageByte = await vm.captureImage(key: key);
                  vm.shareImage(resultImageByte);
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
      ),
    );
  }
}
