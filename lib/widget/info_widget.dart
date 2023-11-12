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
      infoTile(
          image: 'assets/images/Dorothy.jpg',
          title: '밝고 선명한 사진 ✅',
          subtitle: '어둡고 흐린 사진은...'),
      infoTile(
          image: 'assets/images/Dorothy.jpg',
          title: '밝고 선명한 사진 ✅',
          subtitle: '어둡고 흐린 사진은...'),
      infoTile(
          image: 'assets/images/Dorothy.jpg',
          title: '밝고 선명한 사진 ✅',
          subtitle: '어둡고 흐린 사진은...'),
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
      infoTile(
          image: 'assets/images/Dorothy.jpg',
          title: '밝고 선명한 사진 ❌',
          subtitle: '어둡고 흐린 사진은...'),
      infoTile(
          image: 'assets/images/Dorothy.jpg',
          title: '밝고 선명한 사진 ❌',
          subtitle: '어둡고 흐린 사진은...'),
      infoTile(
          image: 'assets/images/Dorothy.jpg',
          title: '밝고 선명한 사진 ❌',
          subtitle: '어둡고 흐린 사진은...'),
    ],
  );
}

Widget infoTile(
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
