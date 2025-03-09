import 'package:bpsdm_mobilev1/model/jadwal_model.dart';
import 'package:bpsdm_mobilev1/screen/widget/card_jadwal.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/api_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JadwalScreen extends ConsumerWidget {
  const JadwalScreen({super.key});

  Future<void> _refreshData(BuildContext context, WidgetRef ref) async {
    ref.invalidate(jadwalProvider); // Memuat ulang data dari provider
    // await ref.read(jadwalProvider.future);
    print(_refreshData(context, ref));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jadwalAsyncValue = ref.watch(jadwalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jadwal Pelatihan"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth =
                constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
            return SizedBox(
              width: maxWidth,
              child: jadwalAsyncValue.when(
                data: (List<JadwalModel> jadwalList) => jadwalList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Belum ada jadwal",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _refreshData(context, ref);
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Muat Ulang"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
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
                              child: CardJadwal(
                                namaPelatihan: jadwal.namaPelatihan,
                                tanggalPelatihan: jadwal.tanggalPelatihan,
                                jenisPelatihan: jadwal.jenisPelatihan,
                                status: jadwal.status,
                                onTap: () {
                                  launchUrl(Uri.parse(jadwal.linkRegis ?? ''),
                                      mode: LaunchMode.externalApplication);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                loading: () => Column(
                  children: List.generate(
                    5,
                    (index) => const ShimmerBox(),
                  ),
                ),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 50),
                      const SizedBox(height: 10),
                      const Text(
                        "Gagal mengambil data. Silakan coba lagi.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          ref.invalidate(jadwalProvider); // Refresh data
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text("Coba Lagi"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
