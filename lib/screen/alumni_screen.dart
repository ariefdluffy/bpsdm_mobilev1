import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlumniScreen extends ConsumerStatefulWidget {
  const AlumniScreen({super.key});

  @override
  _AlumniScreenState createState() => _AlumniScreenState();
}

class _AlumniScreenState extends ConsumerState<AlumniScreen> {
  String selectedYear = "2025"; // Default tahun
  String? selectedPelatihan;
  String searchQuery = "";

  final List<String> years = ["2025", "2024", "2023", "2022", "2021"];
  final List<String> pelatihanList = ["Semua", "Orientasi", "Manajerial"];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final alumniState = ref.watch(alumniProvider);

    void showDetailDialog(
      BuildContext context,
      String namaPeserta,
      String? nip,
      String instansiPeserta,
      String namaPelatihan,
      String tanggalPelatihan,
    ) {
      showDialog(
        context: context,
        barrierDismissible:
            false, // User tidak bisa menutup dialog dengan klik luar
        builder: (context) {
          return AlertDialog(
            title: const Text("Detail Peserta"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$namaPeserta - $nip" ?? "-",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text(
                  instansiPeserta,
                  textAlign: TextAlign.justify,
                ),
                const Divider(),
                Text(
                  namaPelatihan,
                  textAlign: TextAlign.justify,
                ),
                const Divider(),
                Text(
                  "Tanggal Pelatihan: $tanggalPelatihan",
                  textAlign: TextAlign.left,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                },
                child: const Text("Tutup"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Data Alumni")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Tahun
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedYear,
                    items: years.map((year) {
                      return DropdownMenuItem(value: year, child: Text(year));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: "Pilih Tahun"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(alumniProvider.notifier)
                          .fetchAlumni(selectedYear);
                    },
                    child: const Text("Cari"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

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
                          ref.read(alumniProvider.notifier).searchAlumni("");
                          setState(() {}); // Refresh UI agar ikon "X" hilang
                        },
                      )
                    : null,
              ),
            ),

            // Dropdown Pelatihan
            // DropdownButtonFormField<String>(
            //   value: selectedPelatihan,
            //   items: pelatihanList.map((pelatihan) {
            //     return DropdownMenuItem(
            //         value: pelatihan, child: Text(pelatihan));
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedPelatihan = value;
            //     });
            //   },
            //   decoration: const InputDecoration(labelText: "Pilih Pelatihan"),
            // ),

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
                                    fontWeight: FontWeight.bold)),
                            subtitle:
                                Text("Tanggal: ${alumni.tanggalPelatihan}"),
                            onTap: () {
                              showDetailDialog(
                                  context,
                                  alumni.namaPeserta,
                                  alumni.nip ?? "",
                                  alumni.namaPelatihan,
                                  alumni.instansiPeserta,
                                  alumni.tanggalPelatihan);
                              // Menampilkan detail dalam SnackBar
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     // backgroundColor: Colors.grey,
                              //     content: Column(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           "${alumni.namaPeserta} - ${alumni.nip}" ??
                              //               "-",
                              //           textAlign: TextAlign.left,
                              //           style: const TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //         const Divider(),
                              //         Text(
                              //           alumni.instansiPeserta,
                              //           textAlign: TextAlign.justify,
                              //         ),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         const Divider(),
                              //         Text(
                              //           "${alumni.namaPelatihan}\n",
                              //           textAlign: TextAlign.justify,
                              //         ),
                              //         Text(
                              //           "Tanggal Pelatihan: ${alumni.tanggalPelatihan}",
                              //           textAlign: TextAlign.left,
                              //         )
                              //       ],
                              //     ),
                              //     // duration: const Duration(seconds: 60),
                              //     // behavior: SnackBarBehavior.floating,
                              //     duration: const Duration(days: 1),
                              //     action: SnackBarAction(
                              //       label: "Tutup",
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              // );
                            },
                          );
                        },
                      ),
                loading: () => Column(
                    children: List.generate(7, (index) => const ShimmerBox())),
                error: (err, stack) => Center(child: Text("$err")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
