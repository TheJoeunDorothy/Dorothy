import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingVM extends GetxController {
  RxBool isPrivated = false.obs;
  // 잠금 기능
  final LocalAuthentication auth = LocalAuthentication();
  RxBool authorized = false.obs;
  bool isAuthenticating = false;
  late SharedPreferences prefs;

  @override
  onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    await getisPrivatedState();
  }

  /// 일반적인 인증을 수행
  ///
  /// authenticate 메서드를 사용하여 사용자 인증을 시도하고, 그 결과를 _authorized 변수에 업데이트
  authenticate() async {
    try {
      isAuthenticating = true;
      authorized.value = await auth.authenticate(
          localizedReason: '핸드폰 비밀번호를 입력해 주세요.',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ));
      return authorized.value;
    } finally {
      isAuthenticating = false;
    }
  }

  /// 인증을 취소
  cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating = false;
  }

  /// 인증 기능을 설정
  setisPrivatedState(bool value) async {
    await prefs.setBool('isPrivated', value);
  }

  /// 인증 기능이 켜져 있는지 확인
  getisPrivatedState() async {
    bool isPrivatedValue = prefs.getBool('isPrivated') ?? false;
    isPrivated.value = isPrivatedValue;
  }
}
