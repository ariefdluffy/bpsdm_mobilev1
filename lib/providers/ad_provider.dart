import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

final bannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

class BannerAdNotifier extends StateNotifier<BannerAd?> {
  BannerAdNotifier() : super(null) {
    _loadBannerAd();
  }

  void _loadBannerAd() {
    final BannerAd banner = BannerAd(
      size: AdSize.banner,
      adUnitId:
          'ca-app-pub-2393357737286916/2659110471', // ✅ Ganti dengan ID asli
      listener: BannerAdListener(
        onAdLoaded: (ad) => state = ad as BannerAd,
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          state = null;
        },
      ),
      request: const AdRequest(),
    );

    banner.load();
  }
}

final adHelperProvider = Provider<AdHelper>((ref) => AdHelper());

class AdHelper {
  InterstitialAd? _interstitialAd;

  void loadAd(VoidCallback onAdDismissed) {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-2393357737286916/5672055117', // Gunakan ID iklan test atau ID iklan Anda
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              onAdDismissed();
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          Logger().e('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showAd(BuildContext context) {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      Logger().i('InterstitialAd is not ready yet.');
    }
  }
}
