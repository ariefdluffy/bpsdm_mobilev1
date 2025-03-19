import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box_err.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSlider extends ConsumerWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beritaAsyncValue = ref.watch(beritaProvider);

    String ellipsisText(String text, int maxLength) {
      return (text.length > maxLength)
          ? "${text.substring(0, maxLength)}..."
          : text;
    }

    return Expanded(
      child: SizedBox(
        height: 240,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            return beritaAsyncValue.when(
              data: (beritaList) => CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: screenWidth > 600 ? 0.5 : 0.8,
                  height: 270.0,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                ),
                items: beritaList.map((item) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text("Lebar layar: $screenWidth"),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              // clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                item.imgUrl,
                                fit: BoxFit.cover,
                                width: screenWidth * 0.9,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error,
                                      size: 150, color: Colors.red);
                                },
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: SizedBox(
                                // height: 40,
                                width: 0.65 * MediaQuery.of(context).size.width,
                                // width: double.infinity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      ellipsisText(item.judul, 80),
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
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
              error: (err, stack) {
                return Column(
                  children: List.generate(1, (index) => const ShimmerBoxErr()),
                );
              },
              loading: () => Column(
                children: List.generate(
                  1,
                  (index) => const ShimmerBox(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
