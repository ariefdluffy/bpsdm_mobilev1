import 'package:bpsdm_mobilev1/ads/interstitial_ads_page.dart';
import 'package:bpsdm_mobilev1/screen/widget/ad_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteBpsdm extends StatefulWidget {
  const WebsiteBpsdm({super.key});

  @override
  State<WebsiteBpsdm> createState() => _WebsiteBpsdmState();
}

class _WebsiteBpsdmState extends State<WebsiteBpsdm> {
  final InterstitialAdHelper _adHelper = InterstitialAdHelper();

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // ❌ Blokir pop biasa agar bisa tampilkan iklan dulu
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onWillPop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Website Resmi'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BannerAdWidget(),
                  _buildItemList(
                      FontAwesomeIcons.blog,
                      'Website BPDSM',
                      'https://bpsdm.kaltimprov.go.id/web',
                      'https://bpsdm.kaltimprov.go.id/web'),
                  _buildItemList(
                      FontAwesomeIcons.building,
                      'SIMPEL BPSDM',
                      'https://simpel.kaltimprov.go.id/',
                      'https://simpel.kaltimprov.go.id/'),
                  _buildItemList(
                      FontAwesomeIcons.bookAtlas,
                      'E-Learning BPDSM',
                      'https://elearning.kaltimprov.go.id/',
                      'https://elearning.kaltimprov.go.id/'),
                  _buildItemList(
                      FontAwesomeIcons.alignLeft,
                      'Database Inovasi',
                      'https://bpsdm.kaltimprov.go.id/apps/dinov',
                      'https://bpsdm.kaltimprov.go.id/apps/dinov'),
                  _buildItemList(
                      FontAwesomeIcons.cloud,
                      'PiAwan',
                      'http://bpsdmkaltim.quickconnect.to/',
                      'http://bpsdmkaltim.quickconnect.to/'),
                  _buildItemList(
                      FontAwesomeIcons.compass,
                      'AKPK',
                      'https://akpk.kaltimprov.go.id/',
                      'https://akpk.kaltimprov.go.id/'),
                  _buildItemList(
                      FontAwesomeIcons.fileArrowUp,
                      'NIJ',
                      'https://nij.kaltimprov.go.id/',
                      'https://nij.kaltimprov.go.id/'),
                  _buildItemList(
                      FontAwesomeIcons.clock,
                      'SiMonBangKom',
                      'https://simonbangkom.kaltimprov.go.id/',
                      'https://simonbangkom.kaltimprov.go.id/'),
                  _buildItemList(
                      FontAwesomeIcons.compass,
                      'KMS',
                      'https://kms.kaltimprov.go.id/',
                      'https://kms.kaltimprov.go.id/'),
                  _buildItemList(FontAwesomeIcons.exclamation, 'Lapor.go.id',
                      'https://www.lapor.go.id/', 'https://www.lapor.go.id/'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildItemList(
    IconData icon, String title, String url, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    child: InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.blueAccent.withOpacity(0.2), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                child: Icon(icon, size: 28, color: Colors.blueAccent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
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
