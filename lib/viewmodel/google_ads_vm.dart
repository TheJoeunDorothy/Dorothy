import 'package:dorothy/view/result_screen.dart';
import 'package:dorothy/viewmodel/result_vm.dart';
import 'package:dorothy/viewmodel/vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ADS extends GetxController {
  Rx<BannerAd?> bannerAd = Rx<BannerAd?>(null);
  InterstitialAd? interstitialAd;
  RxBool isAdLoaded = false.obs;
  RxBool isAdFrontLoaded = false.obs;
  late Map<String, dynamic> result;

  @override
  void onInit() {
    super.onInit();
    createBannerAd();
    loadAd();
  }

  void createBannerAd() {
    bannerAd.value = BannerAd(
      adUnitId: dotenv.env['GOOGLE_ADS_BANNER_KEY']!,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          bannerAd.value = null;
          isAdLoaded.value = false;
        },
      ),
    );

    bannerAd.value!.load();
  }

  // 전면 광고 실행시 서버로 데이터 이동
  void loadAd() {
    final VM vm = Get.put(VM());
    InterstitialAd.load(
      adUnitId: dotenv.env['GOOGLE_ADS_FRONT_KEY']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // 광고 실행
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isAdFrontLoaded.value = true;

          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            // 광고 로드 시 호출
            onAdShowedFullScreenContent: (ad) async {
              // 서버 데이터 전송
              result = await vm.sendImage();
            },
            onAdDismissedFullScreenContent: (ad) async {
              // 사용자가 광고를 종료시 호출
              handleResult(result, vm);
              ad.dispose();
              // 새로운 광고를 로드.
              loadAd();
            },
            //광고 실패시 호출
            onAdFailedToShowFullScreenContent: (ad, error) {
              _predDialog();
              ad.dispose();
            },
          );
        },
        // 광고 로드 실패시
        onAdFailedToLoad: (LoadAdError error) {
          _predDialog();
        },
      ),
    );
  }

  // 서버 전송
  void handleResult(Map<String, dynamic> result, VM vm) {
    try {
      if (result['result'] == null ||
          result['age'] == null ||
          result['percent'] == null) {
        _predDialog();
      } else {
        ResultVM controller = Get.put(ResultVM());
        controller.result = result;
        controller.originalImage = vm.base64Image;
        vm.insertLogs();
        Get.off(() => const ResultScreen());
      }

      vm.isLoading.value = false;
    } catch (e) {
      _predDialog();
      vm.isLoading.value = false;
    }
  }

  @override
  void onClose() {
    bannerAd.value?.dispose();
    super.onClose();
  }
}

// 다이얼로그
Future<void> _predDialog() {
  ScreenUtil screenUtil = ScreenUtil();
  return Get.dialog(
    barrierDismissible: false,
    // ScreenUtil 초기화
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        '오류가 발생했어요.\n사진을 다시 찍어주세요.',
        style: TextStyle(
          fontSize: 20.sp,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SizedBox(
          width: screenUtil.screenWidth,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text(
              "사진 다시 찍으러 가기",
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
