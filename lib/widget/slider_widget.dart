import 'package:flutter/cupertino.dart';

/// 결과 페이지 위젯 두 개 pageView
Widget sliderWidget({
  required vm,
  required double pageHeight,
  required Widget firstWidget,
  required Widget secondWidget,
  Color? textColor,
  Color? primaryColor
  }) {
  return SizedBox(
    // pageView 높이
    height: pageHeight,
    child: PageView.builder(
      controller: vm.pageController,
      itemCount: 2,
      onPageChanged: (index) {
        // 페이지 넘길 때 인덱스 바꿔주기
        vm.currentPage.value = index;
      },
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? firstWidget
            : secondWidget;
      },
    ),
  );
}
