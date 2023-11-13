
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget agePercentIndicator(context, int age, double percent, Color color) {
  return Padding(
    padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: Text(
            '$age대',
            style: TextStyle(fontSize: 15.sp)
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
          ),
          progressColor: color,
          barRadius: const Radius.circular(10),
        ),
      ],
    ),
  );
}