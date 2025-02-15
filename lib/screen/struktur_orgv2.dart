import 'package:flutter/material.dart';

class StrukturOrgScreen extends StatefulWidget {
  const StrukturOrgScreen({super.key});

  @override
  _StrukturOrgScreenState createState() => _StrukturOrgScreenState();
}

class _StrukturOrgScreenState extends State<StrukturOrgScreen> {
  bool showDivisions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Struktur Organisasi"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                _buildOrgBox("Kepala", "Dra. Nina Dewi, M.AP", Colors.blue),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOrgBox("Sekretaris", "Anna Midawaty, S.Kom., M.M.",
                        Colors.green),
                    // _buildOrgBox("Kepala", "Wakil 2", Colors.green),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showDivisions = !showDivisions;
                        });
                      },
                      child: _buildOrgBox(
                          "Kepala Bidang Pengembangan Kompetensi Teknis",
                          "Apriyana",
                          Colors.green),
                    ),
                  ],
                ),
                if (showDivisions) ...[
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _buildOrgBox("Kepala", "Divisi A", Colors.orange),
                      _buildOrgBox("Kepala", "Divisi B", Colors.orange),
                      _buildOrgBox("Kepala", "Divisi C", Colors.orange),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrgBox(String jabatan, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 220,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Wrap(children: [
                  Text(
                    jabatan,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]),
                const Divider(),
                Wrap(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
