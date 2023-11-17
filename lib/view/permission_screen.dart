import 'package:dorothy/static/agreement.dart';
import 'package:dorothy/view/camera_screen.dart';
import 'package:dorothy/viewmodel/permission_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionVM = Get.put(PermissionVM());

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 10.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      '도로시의 서비스를 이용하기 위해',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
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
              ),
              SizedBox(
                height: 40.h,
              ),
              _buildListTile(
                icon: Icons.camera_alt,
                title: '카메라',
                subtitle: '사진 촬영과 이미지 업로드를 통해 퍼스널 컬러와 나이 예측이 가능합니다.',
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildListTile(
                icon: Icons.mic,
                title: '마이크',
                subtitle: '카메라 기능을 사용하기 위해 마이크 권한이 필요합니다.',
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Text(
                  '서비스 이용 약관',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 240.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5.r),
                ),
                  child: CupertinoScrollbar(
                    thickness: 5.w,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: MarkdownBody(
                              softLineBreak: true,
                              data: Agreement.personalCollection,
                              styleSheet: MarkdownStyleSheet(
                                h2: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Obx(()=> CupertinoCheckbox(
                        value: permissionVM.isTermsCheck.value, 
                        onChanged: (value) => permissionVM.checkBoxChangeAction(),),
                    ),
                    Text(
                      '서비스 이용약관 동의',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' (필수)',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => CupertinoButton.filled(
                      onPressed: permissionVM.isTermsCheck.value ? () => onJoin() : null,
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
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
