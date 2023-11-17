import 'package:dorothy/lang/ko_kr.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // 'en_us': enUS,
    'ko_KR': koKR,
  };
}