import 'package:bpsdm_mobilev1/ads/interstitial_ads_page.dart';
import 'package:bpsdm_mobilev1/providers/ad_provider.dart';
import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailBerita extends ConsumerStatefulWidget {
  const DetailBerita({super.key});

  @override
  ConsumerState<DetailBerita> createState() => _DetailBeritaState();
}

class _DetailBeritaState extends ConsumerState<DetailBerita> {
  final InterstitialAdHelper _adHelper = InterstitialAdHelper();

  @override
  void initState() {
    super.initState();

    _adHelper.loadAd(() {
      Navigator.pop(context); // 🔄 Kembali ke Home setelah iklan ditutup
    });
  }

  /// 🔹 Tangani event "Back"
  bool _onWillPop() {
    _adHelper.showAd(context);
    return false; // ❌ Cegah navigasi langsung tanpa menampilkan iklan
  }

  @override
  void dispose() {
    _adHelper.disposeAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final beritaAsyncValue = ref.watch(detailBeritaProvider);

    return PopScope(
      canPop: false, // ❌ Blokir pop biasa agar bisa tampilkan iklan dulu
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onWillPop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Berita Umum'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: beritaAsyncValue.when(
          data: (berita) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          berita.judul,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Image.network(
                          fit: BoxFit.cover,
                          berita.imgUrl,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error,
                                size: 50, color: Colors.red);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          berita.content.replaceAll('\n\n\n', '\n'),
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 50),
                const SizedBox(height: 10),
                const Text(
                  "Gagal mengambil data. Silakan coba lagi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(detailBeritaProvider); // Refresh data
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Coba Lagi"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
