import 'package:bpsdm_mobilev1/model/alumni_model.dart';
import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:bpsdm_mobilev1/screen/widget/detail_peserta_dialog.dart';
import 'package:bpsdm_mobilev1/screen/widget/dropdown_jenis.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    // void showDetailDialog(
    //   BuildContext context,
    //   String namaPeserta,
    //   String? nip,
    //   String instansiPeserta,
    //   String namaPelatihan,
    //   String tanggalPelatihan,
    // ) {
    //   showModalBottomSheet(
    //     context: context,
    //     backgroundColor: Colors.white,
    //     isScrollControlled: true,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    //     ),
    //     // barrierDismissible:
    //     //     false, // User tidak bisa menutup dialog dengan klik luar
    //     builder: (context) {
    //       return Padding(
    //         padding: const EdgeInsets.all(20),
    //         child: Container(
    //           color: Colors.white,
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               const SizedBox(height: 10),
    //               // Icon Profil
    //               const CircleAvatar(
    //                 radius: 40,
    //                 backgroundColor: Colors.blueAccent,
    //                 child: Icon(Icons.person, size: 50, color: Colors.white),
    //               ),
    //               const SizedBox(height: 10),

    //               // Nama & NIP
    //               Text(
    //                 "$namaPeserta - $nip",
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //                 textAlign: TextAlign.center,
    //               ),
    //               const SizedBox(height: 10),
    //               const Divider(),
    //               const SizedBox(height: 10),
    //               // Instansi
    //               Row(
    //                 children: [
    //                   const Icon(Icons.business, color: Colors.blueAccent),
    //                   const SizedBox(width: 10),
    //                   Expanded(
    //                     child: Text(
    //                       instansiPeserta,
    //                       style: GoogleFonts.poppins(fontSize: 14),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(height: 10),

    //               // Nama Pelatihan
    //               Row(
    //                 children: [
    //                   const Icon(Icons.school, color: Colors.green),
    //                   const SizedBox(width: 10),
    //                   Expanded(
    //                     child: Text(
    //                       namaPelatihan,
    //                       style: GoogleFonts.poppins(fontSize: 14),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(height: 20),

    //               // Tanggal Pelatihan
    //               Row(
    //                 children: [
    //                   const Icon(Icons.date_range, color: Colors.orange),
    //                   const SizedBox(width: 20),
    //                   Expanded(
    //                     child: Text(
    //                       tanggalPelatihan,
    //                       style: GoogleFonts.poppins(fontSize: 14),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(height: 20),

    //               // Tombol Tutup
    //               ElevatedButton.icon(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 icon: const Icon(Icons.close),
    //                 label: const Text("Tutup"),
    //                 style: ElevatedButton.styleFrom(
    //                   backgroundColor: Colors.redAccent,
    //                   foregroundColor: Colors.white,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 12, horizontal: 10),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Alumni"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          double maxWidth =
              constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
          return SizedBox(
            width: maxWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
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
                          decoration:
                              const InputDecoration(labelText: "Pilih Tahun"),
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
                          child: const Text("Cari"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
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
                                    ellipsisText(alumni.namaPelatihan, 100),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  // subtitle: Text(
                                  //   "Tgl: ${formatTanggal(alumni.tanggalPelatihan)}",
                                  //   style: const TextStyle(fontSize: 12),
                                  // ),
                                  onTap: () {
                                    // showDetailDialog(
                                    //   context,
                                    //   alumni.namaPeserta,
                                    //   alumni.nip ?? "",
                                    //   alumni.namaPelatihan,
                                    //   alumni.instansiPeserta,
                                    //   formatTanggal(alumni.tanggalPelatihan),
                                    // );
                                    showDetailDialogNew(context, alumni);
                                  },
                                );
                              },
                            ),
                      loading: () => Column(
                          children:
                              List.generate(7, (index) => const ShimmerBox())),
                      error: (err, stack) => Center(child: Text("$err")),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
