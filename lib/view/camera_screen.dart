import 'package:camera/camera.dart';
import 'package:dorothy/view/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  // 디바이스 별 전면 카메라 확인 및 적용
  Future<void> initCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras?.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    controller = CameraController(frontCamera!, ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 제한
        actions: [
          IconButton(
            onPressed: () => Get.defaultDialog(
                backgroundColor: Colors.white,
                title: '설명창',
                actions: [
                  CupertinoButton.filled(
                    child: Text('확인'),
                    onPressed: () => Get.back(),
                  ),
                ]),
            icon: const Icon(Icons.info_outlined),
          ),
          IconButton(
            onPressed: () => Get.to(const SettingsScreen()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      // 카메라 화면 비율 설정
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: CameraPreview(controller!),
              ),
            ),
          ],
        ),
      ),
      // 바텀 갤러리, 사진, 보관함
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 230.h,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 갤러리 사진 등록
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.photo,
                    ),
                    onPressed: () {
                      //
                    },
                  ),
                  const Text("사진 업로드", style: TextStyle(fontSize: 8)),
                ],
              ),
              // 카메라 촬영시 예측 페이지
              SizedBox(
                width: 75.w,
                height: 75.h,
                child: FloatingActionButton(
                  onPressed: () {
                    //
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.black, width: 5.0),
                  ),
                  child: const Icon(Icons.photo_camera),
                ),
              ),
              // 결과 리스트 페이지
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.list_alt_rounded,
                    ),
                    onPressed: () {
                      //
                    },
                  ),
                  const Text("Dorothy 갤러리", style: TextStyle(fontSize: 3)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 카메라 메모리 제거
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
