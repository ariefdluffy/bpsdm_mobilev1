import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url = 'https://mgleiuwkasvgqcafmxqi.supabase.co';
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1nbGVpdXdrYXN2Z3FjYWZteHFpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg0MTYyNjYsImV4cCI6MjA1Mzk5MjI2Nn0.M0HlvgDvr61ejMsXy9tuWi_7ksOBNSCMRMH6fuYiIvk';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
