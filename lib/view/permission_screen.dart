import 'package:dorothy/view/camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0, // 그림자 제거
        backgroundColor: Colors.white, // 배경색 변경
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //SizedBox(height: 10.h),
              Column(
                children: [
                  Text(
                    '도로시의 서비스를 이용하기 위해',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '필수 권한들을 허용해 주세요',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              _buildListTile(
                icon: Icons.camera_alt,
                title: '카메라',
                subtitle: '사진 촬영과 이미지 업로드를 통해 퍼스널 컬러와 나이 예측이 가능합니다.',
              ),
              _buildListTile(
                icon: Icons.mic,
                title: '마이크',
                subtitle: '카메라 기능을 사용하기 위해 마이크 권한이 필요합니다.',
              ),
              SizedBox(height: 150.h), // 아이콘과 버튼 사이의 간격 설정
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: () => onJoin(),
                    child: Text(
                      '확인',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.r,
        backgroundColor: Colors.grey[200],
        child: Icon(
          icon,
          size: 25.r,
        ),
      ),
      title: Wrap(
        children: [
          Text(
            '$title ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          Text(
            '(필수)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
              color: Colors.red,
            ),
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }

  Future<PermissionStatus> _handleCameraAndLibrary(
      Permission permission) async {
    final status = await permission.request();
    //print(status);
    return status;
  }

  onJoin() async {
    // 카메라, 갤러리 권한 상태 저장
    await _handleCameraAndLibrary(Permission.camera);
    //await _handleCameraAndLibrary(Permission.photos);
    await _handleCameraAndLibrary(Permission.microphone);

    Get.offAll(() => CameraScreen());
    // if (cameraStatus.isGranted && photosStatus.isGranted && microphoneStatus.isGranted) {
    //   Get.to(const CameraScreen());
    // } else {
    //   //openAppSettings();
    // }
  }
}
