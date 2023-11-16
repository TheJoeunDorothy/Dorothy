import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// pageView 인디케이터
Widget infoSliderIndicator(vm) {
  return Obx(
    () => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        return Container(
          width: vm.currentPage.value == index ? 8 : 6,
          height: vm.currentPage.value == index ? 8 : 6,
          margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 2.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: vm.currentPage.value == index
                ? const Color.fromRGBO(0, 0, 0, 0.9)
                : const Color.fromRGBO(0, 0, 0, 0.4),
          ),
        );
      }),
    ),
  );
}
