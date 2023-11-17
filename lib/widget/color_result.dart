import 'dart:convert';
import 'package:dorothy/static/assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget colorResult(context, String base64Image, Map<String, dynamic> result, Color textColor, Color primaryColor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start, 
    children: [
      Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 245.w),
                child: SizedBox(
                  height: 55.h,
                  child: Image.asset(AssetsImage.EMPHASIZING_EFFECT),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 40.h,),
              // 카메라 이미지
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 4.w, color: textColor),
                    borderRadius: BorderRadius.circular(55.r),
                  ),
                  height: 230.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Image.memory(base64Decode(base64Image)),
                  ),
                ),
              ),
            ],
          ),
        ],

      ),
      SizedBox(
        height: 25.h,
      ),
      Text(
        'color_result'.tr,
        style: TextStyle(
          fontSize: 18.sp,
          color: textColor,
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        '${result['result']}',
        style: TextStyle(
          fontSize: 30.sp,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 20.h,),
    ]
  );
}
