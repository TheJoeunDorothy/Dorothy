
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
/// 나이 퍼센트
///@Param : Context, `int`age, `double`percent,`Color`color
Widget agePercentIndicator(context, int age, double percent, Color indicatorColor, Color textColor, bool isMyAge) {
  return Padding(
    padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: Text(
            '$age대',
            style: TextStyle(
              fontSize: 15.sp,
              color: textColor,
              fontWeight: isMyAge ? FontWeight.bold : FontWeight.normal,
              ),
          ),
        ),
        LinearPercentIndicator(
          width: 200.w,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2000,
          percent: percent / 100,
          center: Text(
            "${(percent).toStringAsFixed(1)}%",
            style: TextStyle(
              color: isMyAge ? Colors.red : Colors.black,
              fontWeight: isMyAge ? FontWeight.bold : FontWeight.normal,
              
            ),
          ),
          progressColor: indicatorColor,
          backgroundColor: Colors.white,
          barRadius: const Radius.circular(10),
        ),
      ],
    ),
  );
}