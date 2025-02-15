import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailBerita extends ConsumerWidget {
  const DetailBerita({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beritaAsyncValue = ref.watch(detailBeritaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Umum'),
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
        error: (err, stack) => Center(child: Text("Error: $err")),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
