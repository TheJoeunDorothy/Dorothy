import 'package:get/get.dart';

class PermissionVM extends GetxController {
  RxBool isTermsCheck = false.obs;

  /// 이용약관 체크박스 상태 변경
  void checkBoxChangeAction(){
    isTermsCheck.toggle();
  }
}
