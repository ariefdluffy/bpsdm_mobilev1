import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSlider extends ConsumerWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beritaAsyncValue = ref.watch(beritaProvider);

    return beritaAsyncValue.when(
      data: (beritaList) => CarouselSlider(
        options: CarouselOptions(
          height: 250.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: beritaList.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    item.imgUrl,
                    fit: BoxFit.scaleDown,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                ),
                const Stack(
                  children: [
                    Opacity(opacity: 0.2),
                    Positioned(
                      top: 40,
                      left: 20,
                      child: Text(
                        "Selamat Datang di BPSDM Mobile",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
      error: (err, stack) => Center(
        child: Text('Terjadi kesalahan: $err'),
      ), // Error handling,
      loading: () => Column(
          children: List.generate(
        1,
        (index) => const ShimmerBox(),
      ) // Tampilkan shimmer effect
          ),
    );
  }
}
