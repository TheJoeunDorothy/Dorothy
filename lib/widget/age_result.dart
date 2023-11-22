import 'dart:convert';
import 'dart:math';
import 'package:dorothy/static/assets_image.dart';
import 'package:dorothy/widget/age_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 나이 예측 결과 화면
Widget ageResult(BuildContext context, String base64Image, Map<String, dynamic> result, Color textColor, Color primaryColor) {
  // 무지개 색 배열
  const List<Color> colorList = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.blue,
    Color(0xFF0D47A1),
    Colors.purple
  ];
  List<String> ageList = [
    'age_10'.tr,
    'age_20'.tr,
    'age_30'.tr,
    'age_40'.tr,
    'age_50'.tr,
    'age_60'.tr,
    'age_70'.tr,
  ];
  // 모델 나이예측 결과값 (10대~70대)
  final String ageResultString = result['age'];
  // 결과값을 인덱스로 변환 ('10대' -> 0, '70대' -> 6)
  int ageIndex = int.parse(ageResultString.substring(0, 1)) - 1;
  // 결과값에 맞는 인덱스만 true값을 가지는 배열
  final List<bool> resultList = List.generate(7, (index) => index == ageIndex);

  return Column(
    mainAxisAlignment: MainAxisAlignment.start, 
    children: [
      Stack(
        children: [
          // 사진 강조 이펙트
          Row(
            children: [
              SizedBox(width: 245.w,),
              SizedBox(
                height: 55.h,
                child: Image.asset(AssetsImage.EMPHASIZING_EFFECT),
              ),
            ],
          ),
          // 카메라 사진
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 4.w, color: textColor),
                  borderRadius: BorderRadius.circular(55.r),
                ),
                height: 230.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.3),
                          BlendMode.softLight,
                      ),
                      child: Image.memory(base64Decode(base64Image)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 25.h,),
      Text(
        'age_result'.tr,
        style: TextStyle(
          fontSize: 18.sp,
          color: textColor,
        ),
      ),
      SizedBox(height: 10.h,),
      // 결과값 text
      Text(
        ageResultString,
        style: TextStyle(
          fontSize: 30.sp,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 10.h,),
      // 나이 예측 퍼센트 게이지 바 반복 생성
      for (int i = 0; i <= 6; i++)
        agePercentIndicator(context, ageList[i], result['percent'][i] * 100, colorList[i], textColor, resultList[i]),
      SizedBox(height: 30.h,),
    ]
  );
}
