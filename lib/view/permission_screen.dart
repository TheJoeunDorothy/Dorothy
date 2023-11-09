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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '도로시 앱의 서비스를 이용하기 위해\n필수 권한들을 허용해 주세요',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h,),
              _buildListTile(
                icon: Icons.camera_alt,
                title: '카메라',
                subtitle: '사진 촬영과 이미지 업로드를 통해 \n퍼스널 컬러와 나이 예측이 가능합니다.',
              ),
              SizedBox(height: 10.h,),
              _buildListTile(
                icon: Icons.photo_library,
                title: '갤러리',
                subtitle: '원하는 사진을 선택하여 퍼스널 컬러와 \n나이 예측이 가능합니다.',
              ),
              SizedBox(height: 330.h), // 아이콘과 버튼 사이의 간격 설정
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: () => onJoin(),
                    child: const Text('확인'),
                  ),
                ),
              ),
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
        child: Icon(icon),
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
    final statuses = await Future.wait([
      _handleCameraAndLibrary(Permission.camera),
      _handleCameraAndLibrary(Permission.photos),
    ]);

    if (statuses.every((status) => status.isGranted)) {
      Get.to(const CameraScreen());
    } else {
      openAppSettings();
    }
  }
}