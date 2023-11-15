import 'dart:convert';

import 'package:dorothy/widget/age_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ageResult(context, String base64Image, Map<String, dynamic> result) {
  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    SizedBox(
      height: 50.h,
    ),
    SizedBox(
      width: 150.w,
      height: 150.h,
      child: Image.memory(base64Decode(base64Image)),
    ),
    SizedBox(
      height: 20.h,
    ),
    SizedBox(
      height: 20.h,
    ),
    Text(
      '당신의 얼굴 나이는 ${result['age']}입니다.',
      style: TextStyle(fontSize: 23.sp),
    ),
    SizedBox(
      height: 20.h,
    ),
    agePercentIndicator(context, 10, result['percent'][0]*100, Colors.red),
    agePercentIndicator(context, 20, result['percent'][1]*100, Colors.orange),
    agePercentIndicator(context, 30, result['percent'][2]*100, Colors.amber),
    agePercentIndicator(context, 40, result['percent'][3]*100, Colors.green),
    agePercentIndicator(context, 50, result['percent'][4]*100, Colors.blue),
    agePercentIndicator(context, 60, result['percent'][5]*100, Colors.blue[900]!),
    agePercentIndicator(context, 70, result['percent'][6]*100, Colors.purple),
    SizedBox(
      height: 50.h,
    ),
    SizedBox(
      height: 50.h,
    ),
  ]);
}
