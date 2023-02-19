import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';

class AdMob {
  late RewardedAd rewardedAd;
  late BannerAd bannerAd;

  AdMob();
  void createBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AppStrings.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdOpened: (ad) {},
        onAdClosed: (ad) {},
      ),
      request: const AdRequest(),
    )..load();
  }

  getBannerAd() {
    createBannerAd();
    return bannerAd;
  }

  loadRewardedAd() {
    RewardedAd.load(
        adUnitId: AppStrings.rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              rewardedAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {}));
  }

  showRewardedAd() {
    loadRewardedAd();
    rewardedAd.show(onUserEarnedReward: ((ad, reward) {}));

    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
        });
  }
}
