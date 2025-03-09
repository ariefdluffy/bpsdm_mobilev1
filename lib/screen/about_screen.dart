import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Kami'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/logo.png', width: 100),
              // const CircleAvatar(
              //   radius: 40,
              //   backgroundImage: AssetImage('assets/logo.png'),
              // ),
              const SizedBox(height: 10),
              const Text(
                'BPSDM Provinsi Kaltim',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Badan Pengembangan Sumber Daya Manusia (BPSDM) Provinsi Kalimantan Timur adalah lembaga yang berfokus pada pengembangan sumber daya aparatur.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              const Divider(),
              // const Text(
              //   'Ikuti Kami di Media Sosial',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 10),
              // _buildSocialMediaItem(
              //     Icons.facebook,
              //     'Facebook',
              //     'https://www.facebook.com/bpsdmkaltim',
              //     'https://www.facebook.com/bpsdmkaltim'),
              _buildSocialMediaItem(
                  FontAwesomeIcons.instagram,
                  'Instagram',
                  'https://www.instagram.com/bpsdmkaltim',
                  'https://www.instagram.com/bpsdmkaltim'),
              _buildSocialMediaItem(
                  Icons.web,
                  'Website',
                  'https://bpsdm.kaltimprov.go.id',
                  'https://bpsdm.kaltimprov.go.id'),
              _buildSocialMediaItem(
                  FontAwesomeIcons.youtube,
                  'Youtube',
                  'https://www.youtube.com/@bpsdmkaltim',
                  'https://www.youtube.com/@bpsdmkaltim'),
              _buildSocialMediaItem(
                  Icons.email,
                  'Email',
                  'mailto:info@bpsdm.kaltimprov.go.id',
                  'info@bpsdm.kaltimprov.go.id'),
              _buildSocialMediaItem(
                  Icons.verified_sharp, 'Versi Aplikasi', '', '1.0.2'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaItem(
      IconData icon, String title, String url, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14),
        ),
        onTap: () => _launchURL(url),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
