import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ADS extends GetxController {
  Rx<BannerAd?> bannerAd = Rx<BannerAd?>(null);
  RxBool isAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    createBannerAd();
  }

  void createBannerAd() {
    bannerAd.value = BannerAd(
      adUnitId: dotenv.env['GOOGLE_ADS_KEY']!,
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

  @override
  void onClose() {
    bannerAd.value?.dispose();
    super.onClose();
  }
}
