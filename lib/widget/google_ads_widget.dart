import 'package:dorothy/viewmodel/google_ads_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends GetView<ADS> {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isAdLoaded.value
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: controller.bannerAd.value!.size.height.toDouble(),
              child: AdWidget(ad: controller.bannerAd.value!),
            )
          : Container(),
    );
  }
}
