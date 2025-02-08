import 'package:flutter/material.dart';

class VisiScreen extends StatelessWidget {
  const VisiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visi Misi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'VISI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: const Text(
                '“Menjadi Lembaga Yang Andal Dalam Pengembangan Sumber Daya Aparatur”',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            const Text(
              'MISI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "1. Mewujudkan pelayanan prima dalam penyelenggaraan pendidikan dan pelatihan aparatur;\n\n"
                "2. Mewujudkan fasilitas penunjang pembelajaran diklat yang dilengkapi dengan teknologi;\n\n"
                "3. Meningkatkan kinerja aparatur yang profesional dan akuntabel;\n\n"
                "4. Meningkatkan kualitas pendidikan dan pelatihan teknis fungsional, prajabatan dan kepemimpinan;\n\n"
                "5. Meningkatkan dan mengembangkan kerjasama kediklatan dengan pemangku kepentingan.\n\n",
                textAlign: TextAlign.center, // Untuk teks rata kanan-kiri
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
