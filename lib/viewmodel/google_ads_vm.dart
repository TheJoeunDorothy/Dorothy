import 'package:dorothy/viewmodel/camera_vm.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    InterstitialAd.load(
      adUnitId: dotenv.env['GOOGLE_ADS_FRONT_KEY']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // 광고 실행
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isAdFrontLoaded.value = true;

          Future<Map<String, dynamic>>? imageSendFuture;

          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            // 광고 로드 시 호출
            onAdShowedFullScreenContent: (ad) {
              // 서버 데이터 전송
              final cameraVM = Get.find<CameraVM>();
              imageSendFuture = cameraVM.sendImage();
            },
            onAdDismissedFullScreenContent: (ad) async {
              // 사용자가 광고를 종료시 호출
              final cameraVM = Get.find<CameraVM>();
              Map<String, dynamic>? result = await imageSendFuture;
              cameraVM.handleResult(result!);
              ad.dispose();
              // 새로운 광고를 로드.
              loadAd();
            },
            //광고 실패시 호출
            onAdFailedToShowFullScreenContent: (ad, error) {
              final cameraVM = Get.find<CameraVM>();
              cameraVM.predDialog();
              ad.dispose();
            },
          );
        },
        // 광고 로드 실패시
        onAdFailedToLoad: (LoadAdError error) {
          isAdFrontLoaded.value = false;
        },
      ),
    );
  }
}
