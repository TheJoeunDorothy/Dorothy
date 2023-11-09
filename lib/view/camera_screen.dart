import 'package:dorothy/view/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 제한
        actions: [
          IconButton(
            onPressed:() => Get.defaultDialog(
              backgroundColor: Colors.white,
              title: '설명창',
              actions: [
                CupertinoButton.filled(
                  child: Text('확인'),
                  onPressed: () => Get.back(),
                ),
              ]
            ),
            icon: const Icon(Icons.info_outlined),
          ),
          IconButton(
            onPressed: () => Get.to(const SettingsScreen()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

}
