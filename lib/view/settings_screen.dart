import 'package:dorothy/static/version.dart';
import 'package:dorothy/view/agreement_screen.dart';
import 'package:dorothy/view/logs_screen.dart';
import 'package:dorothy/viewmodel/settings_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingVM controller = Get.put(SettingVM());
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
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 40.h, 15.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '버전',
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
            _getSetting(false,
                settingText: '이용 약관', screen: const AgreementScreen()),
            _getSetting(true, settingText: '사진 기록', screen: LogsScreen()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: InkWell(
                child: Container(
                  height: 50.h,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "잠금 모드",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                      ),
                      Obx(
                        () => CupertinoSwitch(
                            value: controller.isPrivated.value,
                            onChanged: (value) async {
                              try {
                                await controller.authenticate();
                                if (controller.authorized.value) {
                                  controller.isPrivated.value = value;
                                  controller.setisPrivatedState(value);
                                }
                              } catch (e) {
                                controller.cancelAuthentication();
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card 대신 만든 페이지 라우트용 위젯
  Widget _getSetting(bool isLocked,
      {required String settingText, required Widget screen}) {
    final SettingVM controller = Get.find<SettingVM>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: GestureDetector(
        onTap: () async {
          if (isLocked) {
            // 비밀 기능이 필요한 경우
            if (controller.isPrivated.value) {
              // 인증이 필요한 경우
              if (controller.authorized.value) {
                Get.to(() => screen);
              } else {
                // 인증을 시도
                try {
                  await controller.authenticate();
                  if (controller.authorized.value) {
                    Get.to(() => screen);
                  }
                } catch (e) {
                  controller.cancelAuthentication();
                }
              }
            } else {
              // 비밀 기능이 필요하지 않은 경우
              Get.to(() => screen);
            }
          } else {
            // 비밀 기능이 필요하지 않은 경우
            Get.to(() => screen);
          }
        },
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
