import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PengaduanScreen extends StatelessWidget {
  const PengaduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaduan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            launchUrl(Uri.parse('https://www.lapor.go.id/'),
                mode: LaunchMode.externalApplication);
          },
          child: const Text(
            "LAPOR.GO.ID",
            style: TextStyle(fontSize: 19),
          ),
        ),
      ),
    );
  }
}
