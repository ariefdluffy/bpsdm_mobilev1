import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

class BannerAdWidgetDepan extends StatefulWidget {
  const BannerAdWidgetDepan({super.key});

  @override
  _BannerAdWidgetDepanState createState() => _BannerAdWidgetDepanState();
}

class _BannerAdWidgetDepanState extends State<BannerAdWidgetDepan> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  Timer? _adReloadTimer;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      // adUnitId:
      //     'ca-app-pub-3940256099942544/6300978111', // 🔹 Ganti dengan ID iklan Anda
      adUnitId:
          'ca-app-pub-2393357737286916/8914910523', // 🔹 Ganti dengan ID iklan Anda
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          Logger().i('❌ Gagal memuat iklan banner: $error');
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isAdLoaded
          ? Container(
              alignment: Alignment.center,
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          : const SizedBox(),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _adReloadTimer?.cancel();
    super.dispose();
  }
}
