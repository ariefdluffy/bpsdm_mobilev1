// import 'package:flutter/foundation.dart';
import 'package:bpsdm_mobilev1/screen/berita_screen.dart';
import 'package:bpsdm_mobilev1/screen/dashboard.dart';
import 'package:bpsdm_mobilev1/screen/faq_screen.dart';
import 'package:bpsdm_mobilev1/screen/jadwal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const Dashboard(),
    const JadwalScreen(),
    // const BeritaScreen(),
    const FaqScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Warna latar belakang
        selectedItemColor: Colors.blue, // Warna ikon terpilih
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Jadwal"),
          // BottomNavigationBarItem(icon: Icon(Icons.article), label: "Berita"),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer), label: "FaQ"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
