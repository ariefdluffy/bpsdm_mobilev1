import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
