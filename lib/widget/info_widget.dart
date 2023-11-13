import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget infoFirst() {
  return Column(
    children: [
      SizedBox(
        height: 30.h,
      ),
      Text(
        '이런 사진이 좋아요',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
      ),
      SizedBox(
        height: 20.h,
      ),
      _infoTile(
          image: 'assets/images/good1.png',
          title: '정면을 바라보는 사진 ✅',
          subtitle: '측면 사진은 정확한 분석이 어려워요.'),
      _infoTile(
          image: 'assets/images/good2.png',
          title: '밝고 선명한 사진 ✅',
          subtitle: '어둡고 흐린 사진은 인식하기 어려워요'),
      _infoTile(
          image: 'assets/images/good3.png',
          title: '얼굴이 가까운 사진 ✅',
          subtitle: '얼굴을 인식하기 쉬운 사진이 좋아요.'),
    ],
  );
}

Widget infoSecond() {
  return Column(
    children: [
      SizedBox(
        height: 30.h,
      ),
      Text(
        '이런 사진은 피해주세요',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
      ),
      SizedBox(
        height: 20.h,
      ),
      _infoTile(
          image: 'assets/images/bad1.png',
          title: '안경을 착용한 사진 ❌',
          subtitle: '안경 착용 시 정확한 결과가 안 나와요'),
      _infoTile(
          image: 'assets/images/bad2.png',
          title: '측면 사진 ❌',
          subtitle: '측면 얼굴은 얼굴 인식이 불가능해요'),
      _infoTile(
          image: 'assets/images/bad3.png',
          title: '전신 사진 ❌',
          subtitle: '얼굴 위주의 사진이 좋아요'),
    ],
  );
}

Widget _infoTile(
    {required String image, required String title, required String subtitle}) {
  return ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        image,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(
        fontSize: 13.sp,
      ),
    ),
  );
}
