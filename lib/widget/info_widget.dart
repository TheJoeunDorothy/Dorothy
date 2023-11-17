import 'package:dorothy/static/assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget infoFirst() {
  return Column(
    children: [
      SizedBox(
        height: 30.h,
      ),
      Text(
        'info_1_message'.tr,
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 18.sp
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      _infoTile(
          image: AssetsImage.INFO_GOOD_1,
          title: 'info_1_1_title'.tr,
          subtitle: 'info_1_1_subtitle'.tr,
      ),
      _infoTile(
          image: AssetsImage.INFO_GOOD_2,
          title: 'info_1_2_title'.tr,
          subtitle: 'info_1_2_subtitle'.tr,
      ),
      _infoTile(
          image: AssetsImage.INFO_GOOD_3,
          title: 'info_1_2_title'.tr,
          subtitle: 'info_1_2_subtitle'.tr,
      ),
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
        'info_2_message'.tr,
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 18.sp
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      _infoTile(
          image: AssetsImage.INFO_BAD_1,
          title: 'info_2_1_title'.tr,
          subtitle: 'info_2_1_subtitle'.tr,
      ),
      _infoTile(
          image: AssetsImage.INFO_BAD_2,
          title: 'info_2_2_title'.tr,
          subtitle: 'info_2_2_subtitle'.tr,
      ),
      _infoTile(
          image: AssetsImage.INFO_BAD_3,
          title: 'info_2_3_title'.tr,
          subtitle: 'info_2_3_subtitle'.tr,
      ),
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
