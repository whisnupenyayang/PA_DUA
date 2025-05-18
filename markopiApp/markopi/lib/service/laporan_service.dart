import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/laporan.dart';               // Pastikan path model benar
import '../providers/connection.dart';         // Path sesuaikan folder project kamu

class LaporanService {
  // Endpoint API untuk laporan
  static const String _endpoint = '/laporans';

  // Fetch semua laporan
  static Future<List<Laporan>>? getAllLaporans() async {
    try {
      final url = Connection.buildUrl(_endpoint);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data']; // Sesuaikan dengan struktur response API
        return data.map((json) => Laporan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load laporan data');
      }
    } catch (e) {
      throw Exception('Error fetching all laporan: $e');
    }
  }

  // Fetch laporan berdasarkan ID
  static Future<Laporan?> getLaporanById(int id) async {
    try {
      final url = Connection.buildUrl('$_endpoint/$id');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Laporan.fromJson(json.decode(response.body)['data']); // Sesuaikan dengan struktur response API
      } else {
        throw Exception('Failed to load laporan with ID: $id');
      }
    } catch (e) {
      throw Exception('Error fetching laporan by ID: $e');
    }
  }

  // Menyimpan laporan baru
  static Future<void> addLaporan(Laporan laporan) async {
    try {
      final url = Connection.buildUrl(_endpoint);

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'judul_laporan': laporan.judulLaporan,
          'isi_laporan': laporan.isiLaporan,
          'id_users': laporan.userId,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add laporan');
      }
    } catch (e) {
      throw Exception('Error adding laporan: $e');
    }
  }

  // Menghapus laporan berdasarkan ID
  static Future<void> deleteLaporan(int id) async {
    try {
      final url = Connection.buildUrl('$_endpoint/$id');
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete laporan with ID: $id');
      }
    } catch (e) {
      throw Exception('Error deleting laporan: $e');
    }
  }
}
