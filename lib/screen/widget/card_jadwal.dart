import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CardJadwal extends StatelessWidget {
  final String namaPelatihan;
  final String tanggalPelatihan;
  final String jenisPelatihan;
  final VoidCallback onTap;

  const CardJadwal({
    super.key,
    required this.namaPelatihan,
    required this.tanggalPelatihan,
    required this.jenisPelatihan,
    required this.onTap,
  });

  String ellipsisText(String text, int maxLength) {
    return (text.length > maxLength)
        ? "${text.substring(0, maxLength)}..."
        : text;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          // Gambar dengan ClipRRect
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
              bottom: Radius.circular(15),
            ),
            child: SizedBox(
              height: 170,
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 230, 234, 236),
                      Color.fromARGB(255, 96, 119, 223)
                    ], // Warna gradient
                    begin: Alignment.topLeft, // Mulai dari kiri atas
                    end: Alignment.bottomRight, // Berakhir di kanan bawah
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    ellipsisText(namaPelatihan, 130),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
          // Tombol Detail di atas gambar
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: ElevatedButton(
          //     onPressed: onTap,
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.black.withOpacity(0.6),
          //       foregroundColor: Colors.white,
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     child: const Text("Detail"),
          //   ),
          // ),
          // // Konten Card (Judul dan Deskripsi)
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ellipsisText(jenisPelatihan, 110),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Tanggal Pelaksanaan: $tanggalPelatihan',
                        style: TextStyle(color: Colors.grey[600]),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Detail"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
