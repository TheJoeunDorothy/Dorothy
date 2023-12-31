import 'package:dorothy/viewmodel/camera_vm.dart';
import 'package:dorothy/widget/info_slider_indicator.dart';
import 'package:dorothy/widget/info_widget.dart';
import 'package:dorothy/widget/slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget infoDialog() {
  final camareVM = Get.find<CameraVM>();
  return Dialog(
    child: Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sliderWidget(
            vm: camareVM, 
            pageHeight: 300.h, 
            firstWidget: infoFirst(), 
            secondWidget: infoSecond(),
          ),
          sliderIndicator(camareVM),
          SizedBox(
            width: 276.w,
            child: Obx(
              () => SizedBox(
                height: 50.h,
                child: CupertinoButton.filled(
                  child: Text(
                    camareVM.currentPage.value == 0 ? 'next_button'.tr : 'confirm_button'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp
                    ),
                  ),
                  onPressed: () {
                    if (camareVM.currentPage.value == 0) {
                      camareVM.pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    } else {
                      Get.back();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
