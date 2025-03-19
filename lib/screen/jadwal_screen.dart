import 'package:bpsdm_mobilev1/model/jadwal_model.dart';
import 'package:bpsdm_mobilev1/screen/widget/ad_banner_widget.dart';
import 'package:bpsdm_mobilev1/screen/widget/card_jadwal.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../providers/api_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JadwalScreen extends ConsumerWidget {
  const JadwalScreen({super.key});

  Future<void> _refreshData(BuildContext context, WidgetRef ref) async {
    ref.invalidate(jadwalProvider); // Menghapus cache dan memicu pemuatan ulang
    await ref.read(jadwalProvider.future); // Memuat ulang data terbaru
    const SnackBar(
      content: Text("Data sudah yang terbaru"),
    );
  }

  String formatTanggal(String input) {
    try {
      initializeDateFormatting('id_ID', '');
      // Pisahkan tanggal awal & akhir dari string
      // List<String> dates = input.split("  ");
      List<String> dates = input.split(" - ");

      // Parsing tanggal dari format `yyyy-MM-dd`
      DateFormat format = DateFormat("dd MMM yyyy", "id_ID");
      DateTime startDate = format.parse("${dates[0]} 2025"); // Tambahkan tahun
      DateTime endDate = format.parse("${dates[1]} 2025");
      // Logger().i("startDate: $startDate");

      // Format tanggal ke `dd MMMM yyyy`
      String formattedStart =
          DateFormat("dd MMMM yyyy", "id_ID").format(startDate);
      String formattedEnd = DateFormat("dd MMMM yyyy", "id_ID").format(endDate);
      // print('return: $formattedStart');
      if (formattedStart == formattedEnd) {
        return formattedEnd;
      } else {
        return "$formattedStart - $formattedEnd";
      }
      // print('return: formattedStart');
      // return "$formattedStart - $formattedEnd";
    } catch (e) {
      return "Format tidak valid";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jadwalAsyncValue = ref.watch(jadwalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jadwal Pelatihan"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.refresh_rounded,
                size: 28, // Ukuran ikon lebih besar
                color: Colors.black54, // Warna ikon yang lebih menarik
              ),
              onPressed: () => _refreshData(context, ref),
              tooltip: 'Refresh Data', // Tooltip untuk UX yang lebih baik
              splashColor: Colors.blueAccent
                  .withOpacity(0.2), // Efek splash saat tombol ditekan
              highlightColor:
                  Colors.transparent, // Hilangkan efek highlight default
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Bentuk tombol dengan sudut melengkung
                ),
              ),
            ),
          ),
        ],
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
                            const BannerAdWidget(),
                            const Text(
                              "Belum ada jadwal pelatihan",
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
                                tanggalPelatihan:
                                    formatTanggal(jadwal.tanggalPelatihan),
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
                      const BannerAdWidget(),
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
