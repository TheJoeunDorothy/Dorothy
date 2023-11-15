import 'package:dorothy/widget/age_result.dart';
import 'package:dorothy/widget/color_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget resultSliderWidget(vm) {
  return SizedBox(
    height: 570.h,
    child: PageView.builder(
      controller: vm.pageController,
      itemCount: 2,
      onPageChanged: (index) {
        vm.currentPage.value = index;
      },
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? ageResult(context, vm.originalImage, vm.result)
            : colorResult(context, vm.originalImage, vm.result);
      },
    ),
  );
}
