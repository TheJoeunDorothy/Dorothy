import 'package:dorothy/viewmodel/vm.dart';
import 'package:dorothy/widget/info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget sliderWidget(vm) {
  final vm = Get.find<VM>();

  return SizedBox(
    height: 290.h,
    child: PageView.builder(
      controller: vm.pageController,
      itemCount: 2,
      onPageChanged: (index) {
        vm.currentPage.value = index;
      },
      itemBuilder: (BuildContext context, int index) {
        return index == 0 ? infoFirst() : infoSecond();
      },
    ),
  );
}
