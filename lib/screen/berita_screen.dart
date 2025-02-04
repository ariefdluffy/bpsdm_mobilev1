import 'package:bpsdm_mobilev1/screen/detail_berita_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/api_provider.dart';

class BeritaScreen extends ConsumerWidget {
  const BeritaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beritaAsyncValue = ref.watch(beritaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Berita")),
      body: beritaAsyncValue.when(
        data: (beritaList) => ListView.builder(
          itemCount: beritaList.length,
          itemBuilder: (context, index) {
            final item = beritaList[index];
            return ListTile(
              title: Text(
                item.judul,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                item.isiBerita,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: SizedBox(
                height: 75,
                width: 75,
                child: Image.network(
                  item.imgUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 50, color: Colors.red);
                  },
                ),
              ),
              onTap: () {
                ref.read(linkBeritaProvider.notifier).state = item.linkBerita;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (centext) => const DetailBerita(),
                  ),
                );
                // print('link: ${item.imgUrl}');
                // print('link berita: ${beritaList[index].linkBerita}');
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
