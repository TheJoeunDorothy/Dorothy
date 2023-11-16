import 'dart:convert';
import 'package:dorothy/widget/age_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 나이 예측 결과 화면
Widget ageResult(BuildContext context, String base64Image, Map<String, dynamic> result, Color textColor, Color primaryColor) {
  List<int> ageList = [10,20,30,40,50,60,70];
  String ageResultString = result['age'];

  int ageIndex = (int.parse(ageResultString.replaceAll('대', '')) - 10) ~/ 10;
  List<bool> resultList = List.generate(7, (index) => index == ageIndex);
  List<Color> colorList = [Colors.red, Colors.orange, Colors.amber, Colors.green, Colors.blue, Colors.blue[900]!, Colors.purple];

  print('결과 !!!!!!!!!!!!!!!!!!!!!$resultList');

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
                  child: Image.asset('assets/images/top_right_effect.png'),
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
                    border: Border.all(width: 5.w, color: primaryColor),
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
        '인공지능이 분석한 당신의 외모 나이는?',
        style: TextStyle(
          fontSize: 18.sp,
          color: textColor,
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        ageResultString,
        style: TextStyle(
          fontSize: 30.sp,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      // 나이 예측 퍼센트 게이지 바 반복 생성
      for (int i = 0; i <= 6; i++)
        agePercentIndicator(context, ageList[i], result['percent'][i] * 100, colorList[i], textColor, resultList[i]),

      SizedBox(
        height: 30.h,
      ),
    ]
  );
}
