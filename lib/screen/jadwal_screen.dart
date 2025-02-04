import 'package:bpsdm_mobilev1/model/jadwal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/api_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JadwalScreen extends ConsumerWidget {
  const JadwalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jadwalAsyncValue = ref.watch(jadwalProvider);

    String ellipsisText(String text, int maxLength) {
      return (text.length > maxLength)
          ? "${text.substring(0, maxLength)}..."
          : text;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Jadwal")),
      body: jadwalAsyncValue.when(
        data: (List<JadwalModel> jadwalList) => ListView.builder(
          itemCount: jadwalList.length,
          itemBuilder: (context, index) {
            final jadwal = jadwalList[index];
            return InkWell(
              onTap: () {
                launchUrl(Uri.parse(jadwal.linkRegis ?? ''),
                    mode: LaunchMode.externalApplication);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // color: Colors.lightBlue[50],
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          ellipsisText(jadwal.namaPelatihan, 60),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                            "Tanggal Pelaksanaan: ${jadwal.tanggalPelatihan}"),
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Colors.blueGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                ellipsisText(jadwal.jenisPelatihan, 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text('Kuota: ${jadwal.kuota} Peserta'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
