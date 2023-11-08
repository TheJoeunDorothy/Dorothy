import 'package:dorothy/view/settings_screen.dart';
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
        actions: [
          IconButton(
            onPressed: () => Get.to(const SettingsScreen()), 
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
