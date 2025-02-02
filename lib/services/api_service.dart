import 'dart:convert';
import 'package:bpsdm_mobilev1/model/berita_model.dart';
import 'package:bpsdm_mobilev1/model/detail_model.dart';
import 'package:bpsdm_mobilev1/model/jadwal_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final linkBerita = '';

  final String baseUrl =
      "https://sincere-longhaired-evening.glitch.me/api"; // Ganti dengan URL server kamu

  Future<List<JadwalModel>> fetchJadwal() async {
    final response = await http.get(Uri.parse('$baseUrl/jadwal'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map((json) => JadwalModel.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data jadwal");
    }
  }

  Future<List<BeritaModel>> fetchBerita() async {
    final response = await http.get(Uri.parse('$baseUrl/berita'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map((json) => BeritaModel.toJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data berita");
    }
  }

  Future<DetailModel> fetchDetailBerita(String url) async {
    final response =
        await http.get(Uri.parse('$baseUrl/berita/detail/?url=$url'));

    // print('url: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return DetailModel.toJson(data);
    } else {
      throw Exception("Gagal mengambil detail berita");
    }
  }
}
