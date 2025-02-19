import 'package:bpsdm_mobilev1/model/alumni_model.dart';
import 'package:bpsdm_mobilev1/model/berita_model.dart';
import 'package:bpsdm_mobilev1/model/detail_model.dart';
import 'package:bpsdm_mobilev1/model/faq_model.dart';
import 'package:bpsdm_mobilev1/model/jadwal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/api_service.dart';

// Inisialisasi API Service
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final jadwalProvider = FutureProvider<List<JadwalModel>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchJadwal();
});

// Provider untuk Berita
final beritaProvider = FutureProvider<List<BeritaModel>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchBerita();
});

final linkBeritaProvider = StateProvider<String>((ref) => "");

// Future Provider untuk mengambil detail berita berdasarkan URL
final detailBeritaProvider = FutureProvider<DetailModel>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final linkBerita = ref.watch(linkBeritaProvider);

  if (linkBerita.isEmpty) {
    throw Exception("URL Berita masih kosong!");
  }

  return apiService.fetchDetailBerita(linkBerita);
});

final faqProvider = FutureProvider<List<FAQModel>>((ref) async {
  final response = await Supabase.instance.client.from('faqs').select();

  // print(response);
  return response.map((faq) => FAQModel.fromJson(faq)).toList();
});

final searchQueryProvider = StateProvider<String>((ref) => "");

final textEditingControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

/// Provider untuk menyimpan ukuran layar
final screenSizeProvider = StateProvider<ScreenSize>((ref) {
  return ScreenSize.mobile; // Default Mobile
});

final alumniProvider =
    StateNotifierProvider<AlumniNotifier, AsyncValue<List<Alumni>>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return AlumniNotifier(apiService);
});

class AlumniNotifier extends StateNotifier<AsyncValue<List<Alumni>>> {
  final ApiService apiService;
  List<Alumni> _allAlumni = []; // Menyimpan data asli sebelum difilter

  AlumniNotifier(this.apiService) : super(const AsyncValue.data([]));

  Future<void> fetchAlumni(String tahun, String kodeJenis) async {
    state = const AsyncValue.loading();

    try {
      final alumniList = await apiService.fetchAlumni(tahun, kodeJenis);
      _allAlumni = alumniList; // Simpan semua data alumni
      state = AsyncValue.data(alumniList);
      // print(alumniList[0].namaPelatihan);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  // Filter alumni berdasarkan pencarian
  void searchAlumni(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allAlumni); // Tampilkan semua jika kosong
    } else {
      final filtered = _allAlumni
          .where((alumni) =>
              alumni.namaPeserta.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filtered);
    }
  }
}

/// Enum untuk menentukan tipe layar
enum ScreenSize { mobile, desktop }
