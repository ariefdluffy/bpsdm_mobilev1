import 'package:bpsdm_mobilev1/main_screen.dart';
import 'package:bpsdm_mobilev1/screen/alumni_screen.dart';
import 'package:bpsdm_mobilev1/screen/websitebpsdm_screen.dart';
import 'package:bpsdm_mobilev1/screen/struktur_org.dart';
import 'package:bpsdm_mobilev1/screen/visimisi_screen.dart';
import 'package:bpsdm_mobilev1/services/api_supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bpsdm_mobilev1/screen/berita_screen.dart';
import 'package:bpsdm_mobilev1/screen/faq_screen.dart';
import 'package:bpsdm_mobilev1/screen/jadwal_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    Logger().i("File berhasil dimuat!");
  } catch (e) {
    Logger().e("Error saat memuat .env: $e");
  }
  await SupabaseConfig.initialize();
  await MobileAds.instance.initialize();

  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        // "/": (context) => const Dashboard(),
        "/jadwal": (context) => const JadwalScreen(),
        "/berita": (context) => const BeritaScreen(),
        "/faq": (context) => const FaqScreen(),
        "/organisasi": (context) => const StrukturOrg(),
        "/website": (context) => const WebsiteBpsdm(),
        "/visimisi": (context) => const VisiMisiPage(),
        "/alumni": (context) => const AlumniScreen(),
      },
      home: Scaffold(
        backgroundColor: Colors.white,
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
