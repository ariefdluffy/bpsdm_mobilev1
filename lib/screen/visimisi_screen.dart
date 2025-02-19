import 'package:flutter/material.dart';

class VisiMisiPage extends StatelessWidget {
  const VisiMisiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Visi & Misi'),
          backgroundColor: Colors.blueAccent,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          double maxWidth =
              constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
          return SizedBox(
            width: maxWidth,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.visibility,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'VISI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '“Menjadi Lembaga Yang Andal Dalam Pengembangan Sumber Daya Aparatur”',
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const Icon(
                    Icons.flag,
                    size: 40,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'MISI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildMisiItem(
                            'Mewujudkan pelayanan prima dalam penyelenggaraan pendidikan dan pelatihan aparatur.'),
                        _buildMisiItem(
                            'Mewujudkan fasilitas penunjang pembelajaran diklat yang dilengkapi dengan teknologi.'),
                        _buildMisiItem(
                            'Meningkatkan kinerja aparatur yang profesional dan akuntabel.'),
                        _buildMisiItem(
                            'Meningkatkan kualitas pendidikan dan pelatihan teknis fungsional, prajabatan, dan kepemimpinan.'),
                        _buildMisiItem(
                            'Meningkatkan dan mengembangkan kerjasama kediklatan dengan pemangku kepentingan.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildMisiItem(String text) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
