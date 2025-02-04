import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BeritaModel {
  final String imgUrl, judul, isiBerita, tanggalBerita, linkBerita;

  BeritaModel({
    required this.imgUrl,
    required this.judul,
    required this.isiBerita,
    required this.tanggalBerita,
    required this.linkBerita,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
      imgUrl: json['imgUrl'] ?? '',
      judul: json['judul'] ?? '',
      isiBerita: json['isiBerita'] ?? '',
      tanggalBerita: json['tanggalBerita'] ?? '',
      linkBerita: json['linkBerita'] ?? '',
    );
  }

  String toJson() => json.encode(toJson());
}
