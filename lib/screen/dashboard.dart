import 'package:bpsdm_mobilev1/screen/widget/ad_banner_widget_depan.dart';
import 'package:bpsdm_mobilev1/screen/widget/carousel_slider.dart';
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
      "title": "Web Resmi",
      "subtitle": "BPSDM",
      "icon": Icons.web_rounded,
      "route": "/website",
      "color": Colors.red
    },
    {
      "title": "Visi-Misi",
      "subtitle": "Organisasi",
      "icon": Icons.account_balance_outlined,
      "route": "/visimisi",
      "color": Colors.blueGrey
    },
    {
      "title": "Alumni",
      "subtitle": "Pelatihan",
      "icon": Icons.local_attraction_rounded,
      "route": "/alumni",
      "color": Colors.pink
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Warna background modern
      appBar: AppBar(
        title: const Text(
          "BPSDM Mobile unOfficial",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const ImageSlider(),

              // 🔹 Title Menu
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Fitur Utama",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),

              // 🔹 Grid Menu
              SizedBox(
                height: 380,
                // height: MediaQuery.of(context).size.height * 0.5,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                    return GridView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1, // Rasio lebih proporsional
                      ),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        var item = menuItems[index];
                        return _buildMenuItem(item, context);
                      },
                    );
                  },
                ),
              ),
              const BannerAdWidgetDepan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, item["route"]);
      },
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: item["color"].withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(3, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: item["color"].withOpacity(0.1),
              child: Icon(item["icon"], size: 20, color: item["color"]),
            ),
            const SizedBox(height: 8),
            Text(
              item["title"],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            if (item["subtitle"].isNotEmpty)
              Text(
                item["subtitle"],
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
