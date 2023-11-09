import 'package:dorothy/view/camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('카메라, 갤러리 권한 설정하시겠습니까? 임시'),
            CupertinoButton.filled(
              onPressed: () => onJoin(),
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
  }

  _handleCameraAndLibrary(Permission permission) async {
    final status = await permission.request();
    print(status);  
  }

  onJoin() async {
      await _handleCameraAndLibrary(Permission.camera);
      await _handleCameraAndLibrary(Permission.photos);

      Get.to(const CameraScreen());
  }

}