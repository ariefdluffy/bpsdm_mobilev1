import 'package:bpsdm_mobilev1/main_screen.dart';
import 'package:bpsdm_mobilev1/screen/pengaduan_screen.dart';
import 'package:bpsdm_mobilev1/screen/struktur_org.dart';
import 'package:bpsdm_mobilev1/screen/visi_screen.dart';
import 'package:bpsdm_mobilev1/services/api_supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bpsdm_mobilev1/screen/berita_screen.dart';
import 'package:bpsdm_mobilev1/screen/faq_screen.dart';
import 'package:bpsdm_mobilev1/screen/jadwal_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        if (settings.name == '/pengaduan') {
          launchUrl(Uri.parse('https://www.lapor.go.id/'));
          return null; // Tidak perlu halaman baru
        }
      },
      routes: {
        // "/": (context) => const Dashboard(),
        "/jadwal": (context) => const JadwalScreen(),
        "/berita": (context) => const BeritaScreen(),
        "/faq": (context) => const FaqScreen(),
        "/organisasi": (context) => const StrukturOrg(),
        "/pengaduan": (context) => const PengaduanScreen(),
        "/visimisi": (context) => const VisiScreen(),
      },
      home: Scaffold(
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth =
                  constraints.maxWidth > 600 ? 600 : constraints.maxWidth;

              return SizedBox(width: maxWidth, child: const MainScreen());
            },
          ),
        ),
      ),
    );
  }
}
