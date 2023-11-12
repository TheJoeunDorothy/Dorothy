import 'package:dorothy/widget/info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sliderWidget(vm) {
  final PageController _pageController = PageController();

  return SizedBox(
    height: 300.h,
    child: PageView.builder(
      controller: _pageController,
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
