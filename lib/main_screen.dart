// import 'package:flutter/foundation.dart';

import 'package:bpsdm_mobilev1/screen/about_screen.dart';
import 'package:bpsdm_mobilev1/screen/dashboard.dart';
import 'package:bpsdm_mobilev1/screen/jadwal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    const AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Warna latar belakang
        selectedItemColor: Colors.purple[300], // Warna ikon terpilih
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Jadwal"),
          // BottomNavigationBarItem(icon: Icon(Icons.article), label: "Berita"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user), label: "About"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
