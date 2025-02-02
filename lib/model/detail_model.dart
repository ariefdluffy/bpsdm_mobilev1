// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DetailModel {
  final String content, imgUrl, judul;
  DetailModel({
    required this.content,
    required this.imgUrl,
    required this.judul,
  });

  factory DetailModel.toJson(Map<String, dynamic> json) {
    return DetailModel(
        imgUrl: json['image'] ?? '',
        judul: json['title'] ?? '',
        content: json['content'] ?? '');
  }

  String toJson() => json.encode(toJson());
}
