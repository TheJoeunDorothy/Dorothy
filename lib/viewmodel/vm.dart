import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';

class VM extends GetxController {
  RxBool cameraState = true.obs;
  RxBool microphoneState = true.obs;
  // 카메라 컨트롤러
  Rx<CameraController?> controller = Rx<CameraController?>(null);
  // 스트리밍 이미지 저장 변수
  RxList<CameraDescription>? cameras = <CameraDescription>[].obs;
  // 이미지 저장 변수
  Rx<InputImage?> inputImage = Rx<InputImage?>(null);
  // 얼굴 인식 검출기
  Rx<FaceDetector?> faceDetector = Rx<FaceDetector?>(null);
  // 카메라 스트리밍 여부
  RxBool isStreaming = false.obs;
  // 얼굴인식 변수
  Rx<Color> myColor = Colors.white.obs;
  // 페이지 이동 했을 시 카메라 스트리밍 확인
  RxBool isPageStreaming = true.obs;
  // 찍은 사진 저장 변수
  Rx<XFile?> image = Rx<XFile?>(null);

  Future<void> getStates() async {
    cameraState.value = await Permission.camera.status.isGranted;
    microphoneState.value = await Permission.microphone.status.isGranted;
  }

  @override
  void onInit() async {
    super.onInit();

    await getStates();
    if (cameraState.value && microphoneState.value) {
      final options = FaceDetectorOptions();
      faceDetector.value = FaceDetector(options: options);
      // 설정 값이 변경 될때마다 실행
      ever(isPageStreaming, handlePageStreaming);
      initCamera();
    }
  }

  // 카메라 설정
  Future<void> initCamera() async {
    cameras?.value = await availableCameras();
    final frontCamera = cameras?.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    controller.value = CameraController(
      frontCamera!,
      ResolutionPreset.medium,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // Android
          : ImageFormatGroup.bgra8888, // iOS
    );
    controller.value!.initialize().then(
      (_) async {
        // 줌 레벨 설정
        await controller.value!.setZoomLevel(1.3);
        startImageStream();
      },
    );
  }

  // 카메라 얼굴 인식
  void startImageStream() async {
    if (isStreaming.value) {
      return;
    }
    isStreaming.value = true;

    controller.value!.startImageStream(
      (image) async {
        inputImage.value = _inputImageFromCameraImage(image);
        final List<Face>? faces =
            await faceDetector.value?.processImage(inputImage.value!);

        // 얼굴 영역 설정
        final Rect iconRect = Rect.fromCenter(
          center: Offset(image.width / 2, image.height / 2),
          width: 290.w,
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
              myColor.value = Colors.amber;
              print("얼굴이다!!!!!!!!!!!!");
            } else {
              print("인식 안된다~~~~~~~");
              myColor.value = Colors.white;
              stopImageStream();
            }
          }
        } else {
          print("인식 안된다~~~~~~~");
          myColor.value = Colors.white;
          stopImageStream();
        }
      },
    );
  }

  // 카메라 얼굴 인식 중지
  void stopImageStream() {
    if (!isStreaming.value) {
      return;
    }
    isStreaming.value = false;
    controller.value!.stopImageStream();

    if (isPageStreaming.value) {
      // 중지 후 다시 시작하는 코드 추가
      Future.delayed(const Duration(seconds: 1), () => startImageStream());
    }
  }

  // InputImage로 변환
  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final camera = controller.value!.description;
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
          orientations[controller.value!.value.deviceOrientation];
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

  // 페이지 이동 스트리밍 설정
  void handlePageStreaming(bool isStreaming) {
    if (cameraState.value && microphoneState.value) {
      if (isStreaming) {
        startImageStream();
      } else {
        stopImageStream();
      }
    }
  }

  // 카메라 촬영
  Future<void> takePicture() async {
    if (!isStreaming.value) {
      throw Exception('스트리밍이 시작되지 않았습니다.');
    }

    image.value = await controller.value!.takePicture();
  }

  @override
  void onClose() {
    controller.value?.dispose();
    faceDetector.value?.close();
    super.onClose();
  }
}
