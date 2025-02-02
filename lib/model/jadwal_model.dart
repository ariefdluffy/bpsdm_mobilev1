import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JadwalModel {
  final String namaPelatihan;
  final String jenisPelatihan;
  final String tanggalPelatihan;
  final String status;
  final String? linkRegis;
  final String kuota;

  JadwalModel({
    required this.namaPelatihan,
    required this.jenisPelatihan,
    required this.tanggalPelatihan,
    required this.status,
    required this.linkRegis,
    required this.kuota,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json) {
    return JadwalModel(
      namaPelatihan: json['namaPelatihan'] ?? '',
      jenisPelatihan: json['jenisPelatihan'] ?? 'salah',
      kuota: json['kuota'] ?? '',
      status: json['status'] ?? '',
      tanggalPelatihan: json['tanggalPelatihan'] ?? '',
      linkRegis: json['linkRegis'] ?? '',
    );
  }

  String toJson() => json.encode(toJson());
}
