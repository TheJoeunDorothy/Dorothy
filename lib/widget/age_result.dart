import 'package:dorothy/widget/age_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ageResult(context) {
  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    SizedBox(height: 50.h,),
    SizedBox(
        width: 150.w,
        height: 150.h,
        child: Image.asset('assets/images/Dorothy.jpg')),
    SizedBox(
      height: 20.h,
    ),
    SizedBox(
      height: 20.h,
    ),
    Text(
      '당신의 얼굴 나이는 30대입니다.',
      style: TextStyle(fontSize: 23.sp),
    ),
    SizedBox(
      height: 20.h,
    ),
    agePercentIndicator(context, 10, 1, Colors.red),
    agePercentIndicator(context, 20, 2, Colors.orange),
    agePercentIndicator(context, 30, 3, Colors.amber),
    agePercentIndicator(context, 40, 4, Colors.green),
    agePercentIndicator(context, 50, 5, Colors.blue),
    agePercentIndicator(context, 60, 6, Colors.blue[900]!),
    agePercentIndicator(context, 70, 7, Colors.purple),
    SizedBox(
      height: 50.h,
    ),
    SizedBox(
      height: 50.h,
    ),
  ]);
}
