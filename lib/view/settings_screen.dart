import 'package:dorothy/view/agreement_screen.dart';
import 'package:dorothy/view/logs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '설정',
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '버전',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                  Text(
                    'v1.0.0 ',
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            _getSetting(settingText: '이용 약관', screen: const AgreementScreen()),
            SizedBox(
              height: 30.h,
            ),
            _getSetting(settingText: '사진 기록', screen: const LogsScreen()),
          ],
        ),
      ),
    );
  }

  Widget _getSetting({required String settingText, required Widget screen}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: InkWell(
        onTap: () => Get.to(screen),
        child: Container(
          height: 50.h,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                settingText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 17.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
