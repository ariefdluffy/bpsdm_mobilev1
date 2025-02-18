class Alumni {
  final String? nip;
  final String namaPeserta;
  final String namaPelatihan;
  final String tanggalPelatihan;
  final String instansiPeserta;

  Alumni({
    required this.nip,
    required this.namaPeserta,
    required this.namaPelatihan,
    required this.tanggalPelatihan,
    required this.instansiPeserta,
  });

  factory Alumni.fromJson(Map<String, dynamic> json) {
    return Alumni(
      nip: json["nip"] ?? "",
      namaPeserta: json["namaPeserta"] ?? "",
      namaPelatihan: json["namaPelatihan"] ?? "",
      tanggalPelatihan: json["tanggalPelatihan"] ?? "",
      instansiPeserta: json["instansiPeserta"] ?? "",
    );
  }
}
