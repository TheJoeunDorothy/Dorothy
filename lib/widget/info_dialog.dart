import 'package:dorothy/viewmodel/vm.dart';
import 'package:dorothy/widget/info_slider_indicator.dart';
import 'package:dorothy/widget/info_widget.dart';
import 'package:dorothy/widget/result_slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget infoDialog() {
  final vm = Get.find<VM>();
  return Dialog(
    child: Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sliderWidget(
            vm: vm, 
            pageHeight: 290.h, 
            firstWidget: infoFirst(), 
            secondWidget: infoSecond(),
          ),
          infoSliderIndicator(vm),
          SizedBox(
            width: 278.w,
            child: Obx(
              () => CupertinoButton.filled(
                child: Text(vm.currentPage.value == 0 ? '다음' : '확인'),
                onPressed: () {
                  if (vm.currentPage.value == 0) {
                    vm.pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  } else {
                    Get.back();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
