import 'package:bpsdm_mobilev1/screen/detail_berita_screen.dart';
import 'package:bpsdm_mobilev1/screen/widget/card.dart';
import 'package:bpsdm_mobilev1/screen/widget/card_berita.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box_err.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/api_provider.dart';

class BeritaScreen extends ConsumerWidget {
  const BeritaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beritaAsyncValue = ref.watch(beritaProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Berita BPSDM")),
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth =
                  constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
              return SizedBox(
                width: maxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: beritaAsyncValue.when(
                    data: (beritaList) => ListView.builder(
                      itemCount: beritaList.length,
                      itemBuilder: (context, index) {
                        final item = beritaList[index];
                        // return ModernCard(
                        //   title: item.judul,
                        //   subtitle: item.isiBerita,
                        //   imageUrl: item.imgUrl,
                        //   onTap: () {
                        //     ref.read(linkBeritaProvider.notifier).state =
                        //         item.linkBerita;
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (centext) => const DetailBerita(),
                        //       ),
                        //     );
                        //   },
                        // );
                        return NewsCard(
                          imageUrl: item.imgUrl,
                          title: item.judul,
                          subtitle: item.isiBerita,
                          onTap: () {
                            ref.read(linkBeritaProvider.notifier).state =
                                item.linkBerita;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (centext) => const DetailBerita(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    error: (err, stack) {
                      return Column(
                          children: List.generate(
                              7, (index) => const ShimmerBoxErr()));
                    },
                    loading: () => Column(
                      children: List.generate(
                        1,
                        (index) => const ShimmerBox(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
