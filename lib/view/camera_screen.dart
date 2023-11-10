import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // 카메라 얼굴 인식
  void startImageStream() async {
    if (isStreaming) {
      // 이미 스트림이 시작되었다면 더 이상 진행하지 않습니다.
      return;
    }
    isStreaming = true;

    controller!.startImageStream(
      (image) async {
        inputImage = _inputImageFromCameraImage(image);
        final List<Face>? faces = await faceDetector?.processImage(inputImage!);

        // 아이콘의 영역을 설정합니다. (아이콘의 크기가 200x200이므로 아이콘의 영역도 이에 맞춰 설정합니다)
        final Rect iconRect = Rect.fromCenter(
          center: Offset(image.width / 2, image.height / 2), // 아이콘은 화면 중앙에 위치
          width: 200, // 아이콘의 너비
          height: 200, // 아이콘의 높이
        );

        // 비어 있지않으면
        if (faces != null && faces.isNotEmpty) {
          for (final face in faces) {
            // 얼굴이 아이콘 영역에 있는지 확인합니다.
            if (iconRect.overlaps(face.boundingBox)) {
              print("얼굴이다!!!!!!!!!!!!");
            } else {
              print("인식 안된다~~~~~~~");
              stopImageStream(); // 얼굴이 아이콘 영역을 벗어나면 스트림을 중지합니다.
            }
          }
        } else {
          print("인식 안된다~~~~~~~");
          stopImageStream(); // 얼굴이 감지되지 않으면 스트림을 중지합니다.
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
              child: Icon(Icons.face,
                  size: 200, color: Colors.white.withAlpha(80)),
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
                        Icons.photo_camera_back_outlined,
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
          )),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    faceDetector?.close();
    super.dispose();
  }
}
