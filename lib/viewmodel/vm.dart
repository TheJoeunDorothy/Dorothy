import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VM extends GetxController {

  RxBool cameraState = true.obs;
  RxBool microphoneState= true.obs;

  
  Future<void> getStates() async {
    cameraState.value = await Permission.camera.status.isGranted;
    microphoneState.value = await Permission.microphone.status.isGranted;
  }
}