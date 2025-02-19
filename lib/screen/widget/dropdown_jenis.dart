import 'package:flutter/material.dart';

class DropdownJenis extends StatefulWidget {
  final String selectedKodeJenis;
  final Function(String?) onChanged;

  const DropdownJenis(
      {required this.selectedKodeJenis, required this.onChanged, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownJenisState createState() => _DropdownJenisState();
}

class _DropdownJenisState extends State<DropdownJenis> {
  final List<Map<String, String>> jenisList = [
    {"value": "0", "label": "Semua"},
    {
      "value": "10",
      "label": "Community of Practices / Sharing Session / Knowledge Sharing"
    },
    {"value": "2", "label": "Fungsional"},
    {"value": "6", "label": "Jabatan Fungsional"},
    {"value": "13", "label": "Lembaga Sertifikasi Pemerintahan"},
    {"value": "24", "label": "Manajerial"},
    {"value": "12", "label": "Orientasi"},
    {
      "value": "15",
      "label":
          "Pameran Jambore Inovasi Kalimantan (JIK) dan Jambore Inovasi Nusantara (JoINus)"
    },
    {"value": "23", "label": "Patok Banding (benchmarking)"},
    {"value": "5", "label": "Pelatihan Dasar CPNS"},
    {"value": "4", "label": "Pelatihan Kepemimpinan Administrator"},
    {"value": "3", "label": "Pelatihan Kepemimpinan Pengawas"},
    {"value": "25", "label": "Pemerintahan Dalam Negeri"},
    {
      "value": "7",
      "label":
          "Pengembangan Kompetensi Pimpinan Daerah dan Jabatan Pimpinan Tinggi"
    },
    {"value": "21", "label": "Pra Uji Kompetensi"},
    {"value": "19", "label": "Pra Uji Kompetensi Pemerintahan"},
    {
      "value": "8",
      "label":
          "Pra Uji Kompetensi Pemerintahan Jabatan Administrator Angkatan II"
    },
    {"value": "17", "label": "Rapat Kerja Kepegawaian"},
    {"value": "14", "label": "Rapat Koordinasi"},
    {"value": "22", "label": "Seminar/Konferensi/Sarasehan"},
    {"value": "26", "label": "Sertifikasi / Uji Kompetensi"},
    {"value": "11", "label": "Sosialisasi"},
    {
      "value": "27",
      "label":
          "Sosialisasi Pedoman Teknis Pengelolaan Sistem Pembelajaran Terintegrasi Dalam Pengembangan Kompetensi ASN dan Pendampingan AKPK"
    },
    {"value": "9", "label": "Sosialisasi Uji Kompetensi"},
    {"value": "16", "label": "Sosiokultural"},
    {"value": "1", "label": "Teknis"},
    {"value": "20", "label": "Uji Kompetensi Pemerintahan"},
    {
      "value": "18",
      "label": "Uji Kompetensi Pemerintahan Jabatan Administrator Angkatan II"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: widget.selectedKodeJenis ?? "0", // Pastikan tidak null
      hint: const Text("Pilih Jenis"),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        // constraints: const BoxConstraints(
        //   maxHeight: 100, //  Batasi tinggi dropdown
        // ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      onChanged: widget.onChanged,
      items: jenisList.map((jenis) {
        return DropdownMenuItem<String>(
          value: jenis["value"],
          child: Text(
            jenis["label"] ?? "Tidak Diketahui",
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      menuMaxHeight: 500,
    );
  }
}
