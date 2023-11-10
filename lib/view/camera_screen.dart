import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dorothy/view/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  InputImage? inputImage;
  FaceDetector? faceDetector;
  bool isStreaming = false;
  Color myColor = Colors.white;

  @override
  void initState() {
    super.initState();
    final options = FaceDetectorOptions();
    faceDetector = FaceDetector(options: options);
    initCamera();
  }

  // 카메라 설정
  Future<void> initCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras?.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    controller = CameraController(
      frontCamera!,
      ResolutionPreset.medium,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // for Android
          : ImageFormatGroup.bgra8888, // for iOS
    );
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      startImageStream();
    });
  }

  // 카메라 얼굴 인식
  void startImageStream() async {
    if (isStreaming) {
      return;
    }
    isStreaming = true;

    controller!.startImageStream(
      (image) async {
        inputImage = _inputImageFromCameraImage(image);
        final List<Face>? faces = await faceDetector?.processImage(inputImage!);

        // 얼굴 영역 설정
        final Rect iconRect = Rect.fromCenter(
          center: Offset(image.width / 2, image.height / 2),
          width: 280.w,
          height: 300.h,
        );

        // 얼굴이 넣어져 있으면
        if (faces != null && faces.isNotEmpty) {
          for (final face in faces) {
            // 얼굴 영역에 들어와 있으면
            if (iconRect.contains(
                    Offset(face.boundingBox.left, face.boundingBox.top)) &&
                iconRect.contains(
                    Offset(face.boundingBox.right, face.boundingBox.bottom))) {
              myColor = Colors.amber;
              setState(() {});
              print("얼굴이다!!!!!!!!!!!!");
            } else {
              print("인식 안된다~~~~~~~");
              myColor = Colors.white;
              stopImageStream();
            }
          }
        } else {
          print("인식 안된다~~~~~~~");
          myColor = Colors.white;
          stopImageStream();
        }
      },
    );
  }

// 카메라 얼굴 인식 중지
  void stopImageStream() {
    if (!isStreaming) {
      // 스트림이 이미 중지되었다면 더 이상 진행하지 않습니다.
      return;
    }
    isStreaming = false;

    controller!.stopImageStream();
    // 중지 후 다시 시작하는 코드 추가
    Future.delayed(Duration(seconds: 1), () => startImageStream());

    setState(() {});
  }

  // InputImage로 변환
  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final camera = controller!.description;
    final sensorOrientation = camera.sensorOrientation;
    final orientations = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeLeft: 90,
      DeviceOrientation.portraitDown: 180,
      DeviceOrientation.landscapeRight: 270,
    };
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
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
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: CameraPreview(controller!),
              ),
            ),
            Center(
              child: Container(
                width: 230.w, // 사람 얼굴 사이즈에 맞게 조정
                height: 300.h, // 사람 얼굴 사이즈에 맞게 조정
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, // 모서리 틀로 변경
                    border: Border.all(color: myColor, width: 5)),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    faceDetector?.close();
    super.dispose();
  }
}
