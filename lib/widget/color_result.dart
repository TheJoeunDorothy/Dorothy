import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget colorResult(context) {
  return RepaintBoundary(
    child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
        '당신의 예상 퍼스널컬러는',
        style: TextStyle(fontSize: 23.sp),
      ),
      Text(
        '입니다.',
        style: TextStyle(fontSize: 23.sp),
      ),
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        height: 50.h,
      ),
      SizedBox(
        height: 50.h,
      ),
    ]),
  );
}
