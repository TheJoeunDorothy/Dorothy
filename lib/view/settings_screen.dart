import 'package:dorothy/static/version.dart';
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
        title: Text(
          'setting_appbar'.tr,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SizedBox(
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'version'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    Version.now,
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 0.h,
          ),
          _getSetting(settingText: 'terms_of_service'.tr, screen: const AgreementScreen()),
          SizedBox(
            height: 0.h,
          ),
          _getSetting(settingText: 'photo_log'.tr, screen: const LogsScreen()),
        ],
      ),
    );
  }

  /// Card 대신 만든 페이지 라우트용 위젯
  Widget _getSetting({required String settingText, required Widget screen}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: InkWell(
        onTap: () => Get.to(()=> screen),
        child: Container(
          height: 50.h,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                settingText,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
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
