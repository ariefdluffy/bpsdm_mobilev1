import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DetailPesertaDialog extends StatelessWidget {
  final String namaPeserta;
  final String nip;
  final String instansiPeserta;
  final String namaPelatihan;
  final String tanggalPelatihan;

  const DetailPesertaDialog({
    super.key,
    required this.namaPeserta,
    required this.nip,
    required this.instansiPeserta,
    required this.namaPelatihan,
    required this.tanggalPelatihan,
  });

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

      // print('return: formattedStart');
      return "$formattedStart - $formattedEnd";
    } catch (e) {
      return "Format tidak valid";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Profil
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 10),

          // Nama & NIP
          Text(
            "$namaPeserta - $nip",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Divider(),

          // Instansi
          Row(
            children: [
              const Icon(Icons.business, color: Colors.blueAccent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  instansiPeserta,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Nama Pelatihan
          Row(
            children: [
              const Icon(Icons.school, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  namaPelatihan,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Tanggal Pelatihan
          Row(
            children: [
              const Icon(Icons.date_range, color: Colors.orange),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Tanggal: $tanggalPelatihan",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Tombol Tutup
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            label: const Text("Tutup"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context, String namaPeserta, String? nip,
      String instansiPeserta, String namaPelatihan, String formatTanggal) {}
}
