import 'package:flutter/material.dart';

class StrukturOrg extends StatelessWidget {
  const StrukturOrg({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> contactsList = [
      // {
      //   "ruang": "Kepala Badan",
      //   "essiii": "Dra. Nina Dewi, M.AP.",
      //   "essiv1": "",
      //   "essiv2": ""
      // },
      {
        "ruang": "Sekretariat",
        "essiii": "H. Anna Midawaty, S.Kom., M.M.",
        "essiv1": "Samsul Qamar, S.Sos.",
        "essiv2": "Salasiah, S.E."
      },
      {
        "ruang": "Bidang Pengembangan Kompetensi Manajerial dan Fungsional",
        "essiii": "Rina Kusharyanti, S.STP., M.M.",
        "essiv1": "Tajuddin Noor, S.E.",
        "essiv2": "Endang Reny Wahyuti, S.Sos."
      },
      {
        "ruang": "Bidang Pengembangan Kompetensi Teknis",
        "essiii": "Apriyana Rachmawaty, S.Psi.",
        "essiv1": "Indri Widayanti, S.E.",
        "essiv2": "Jafung Analis Bangkom Ahli Pertama"
      },
      {
        "ruang": "Bidang Sertifikasi Kompetensi dan Pengelolaan Kelembagaan",
        "essiii": "Siti Djaitun, S.Sos., M.Si.",
        "essiv1": "Dimas Radhitya Anggara, S.E.",
        "essiv2": "Jafung Analis Bangkom Ahli Pertama"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Struktur Organisasi'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Text(
            'KEPALA BADAN',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Dra. Nina Dewi, M.AP.',
            style: TextStyle(fontSize: 12),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: contactsList.length,
              itemBuilder: (context, index) {
                final contact = contactsList[index];

                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    leading: const Icon(Icons.account_circle_outlined,
                        size: 35, color: Colors.blue),
                    title: Text(
                      contact["ruang"]!,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_pin_outlined,
                            color: Colors.green),
                        title: Text(contact["essiii"]!),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_pin_outlined,
                            color: Colors.red),
                        title: Text(contact["essiv1"]!),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_pin_outlined,
                            color: Colors.orange),
                        title: Text(contact["essiv2"]!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
