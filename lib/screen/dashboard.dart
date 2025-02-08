import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Jadwal",
      "subtitle": "Pelatihan",
      "icon": Icons.event,
      "route": "/jadwal",
      "color": Colors.blue
    },
    {
      "title": "Berita",
      "subtitle": "Terkini",
      "icon": Icons.article,
      "route": "/berita",
      "color": Colors.green
    },
    {
      "title": "FAQ",
      "subtitle": "",
      "icon": Icons.help,
      "route": "/faq",
      "color": Colors.orange
    },
    {
      "title": "Struktur",
      "subtitle": "Organisasi",
      "icon": Icons.group_remove_rounded,
      "route": "/organisasi",
      "color": Colors.red
    },
    {
      "title": "Pengaduan",
      "subtitle": "Lapor.go.id",
      "icon": Icons.report_gmailerrorred,
      "route": "/pengaduan",
      "color": Colors.red
    },
    {
      "title": "Visi-Misi",
      "subtitle": "Organisasi",
      "icon": Icons.account_balance_outlined,
      "route": "/visimisi",
      "color": Colors.blueGrey
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        const Opacity(opacity: 0.2),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          // child: Image.asset(
                          //   "assets/banner/banner_1.jpg", // Ambil gambar tanpa daftar satu per satu
                          //   width: 200,
                          //   height: 200,
                          //   fit: BoxFit.cover,
                          // ),
                        ),

                        // Teks di Atas Gambar
                        const Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text(
                            "Selamat Datang di BPSDM Mobile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1, // Rasio ukuran card
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    var item = menuItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, item["route"]);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item["icon"], size: 22, color: item["color"]),
                            const SizedBox(height: 5),
                            Text(
                              item["title"],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item["subtitle"],
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // const Row(
              //   children: [Text('data')],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
