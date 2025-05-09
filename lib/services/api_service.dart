import 'dart:convert';
import 'dart:developer';
import 'package:bpsdm_mobilev1/model/alumni_model.dart';
import 'package:bpsdm_mobilev1/model/berita_model.dart';
import 'package:bpsdm_mobilev1/model/detail_model.dart';
import 'package:bpsdm_mobilev1/model/jadwal_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  final linkBerita = '';

  // final String baseUrl =
  //     "http://11.11.11.19:5000/api"; // Ganti dengan URL server kamu
  final String baseUrl =
      "https://backend-scraping-b3mx.onrender.com/api"; // Ganti dengan URL server kamu
  // final String baseUrl =
  //     "https://sincere-longhaired-evening.glitch.me/api"; // Ganti dengan URL server kamu

  Future<List<JadwalModel>> fetchJadwal() async {
    final response = await http.get(Uri.parse('$baseUrl/jadwal/filter'));

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

      return data.map((json) => BeritaModel.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data berita");
    }
  }

  Future<DetailModel> fetchDetailBerita(String url) async {
    final Uri apiUrl = Uri.parse('$baseUrl/berita/detail');
    // print(apiUrl);
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"url": url},
    );

    // print('url: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return DetailModel.fromJson(data);
    } else {
      throw Exception("Gagal mengambil detail berita");
    }
  }

  Future<List<Alumni>> fetchAlumni(String tahun, String kodeJenis) async {
    final uri = Uri.parse("$baseUrl/alumni");

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"tahun": tahun, "kodeJenis": kodeJenis},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        return data.map((item) => Alumni.fromJson(item)).toList();
      } else {
        throw Exception("Gagal mengambil data alumni");
      }
    } catch (e, stackTrace) {
      Logger().e("Error get Alumni: $e");
      Logger().e("StackTrace get Alumni: $stackTrace"); // Untuk debugging
      throw Exception("Gagal mengambil data alumni");
    }
  }
}
