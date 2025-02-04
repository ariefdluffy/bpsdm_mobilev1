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
      "subtitle": "Jadwal Pelatihan BPSDM",
      "icon": Icons.event,
      "route": "/jadwal",
      "color": Colors.blue
    },
    {
      "title": "Berita",
      "subtitle": "Baca Berita Terkini",
      "icon": Icons.article,
      "route": "/berita",
      "color": Colors.green
    },
    {
      "title": "FAQ",
      "subtitle": "Pertanyaan yang sering diajukan",
      "icon": Icons.help,
      "route": "/faq",
      "color": Colors.orange
    },
    {
      "title": "Contact",
      "subtitle": "Hubungi kami",
      "icon": Icons.contact_phone,
      "route": "/contact",
      "color": Colors.red
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                        ),

                        // Teks di Atas Gambar
                        const Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            "Selamat Datang di Dashboard",
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
                    crossAxisCount: 4, // 2 kolom dalam satu baris
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
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
                            Icon(item["icon"], size: 24, color: item["color"]),
                            const SizedBox(height: 5),
                            Text(
                              item["title"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   item["subtitle"],
                            //   style: const TextStyle(
                            //     fontSize: 12,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
