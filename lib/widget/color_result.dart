import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget colorResult(context, String base64Image, Map<String, dynamic> result) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start, 
      children: [
      SizedBox(
        height: 50.h,
      ),
      SizedBox(
        height: 220.h,
        child: Image.memory(base64Decode(base64Image)),
      ),
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        height: 20.h,
      ),
      Text(
        '당신의 예상 퍼스널컬러는 ',
        style: TextStyle(fontSize: 23.sp),
      ),
      Text(
        '${result['result']}입니다.',
        style: TextStyle(fontSize: 23.sp),
      ),
      SizedBox(
        height: 20.h,
      ),
    ]
  );
}
