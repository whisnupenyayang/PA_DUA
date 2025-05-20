import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/laporan.dart';
import '../providers/connection.dart';

class LaporanService {
  // Endpoint API untuk laporan
  static const String _endpoint = '/laporans';

  // Fetch semua laporan
  static Future<List<Laporan>> getAllLaporans() async {
    try {
      final url = Connection.buildUrl(_endpoint);
      
      // Print URL for debugging
      print('Fetching from URL: $url');
      
      final response = await http.get(Uri.parse(url));
      
      // Print response status code for debugging
      print('Response status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        // Print response body for debugging
        print('Response body: ${response.body}');
        
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data']; // Sesuaikan dengan struktur response API
        return data.map((json) => Laporan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load laporan data: Status ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getAllLaporans: $e');
      // Return empty list instead of throwing exception to avoid breaking the UI
      return [];
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
      print('Error in getLaporanById: $e');
      return null;
    }
  }

  // Menyimpan laporan baru
  static Future<bool> addLaporan(Laporan laporan) async {
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
      return response.statusCode == 201;
    } catch (e) {
      print('Error in addLaporan: $e');
      return false;
    }
  }

  // Menghapus laporan berdasarkan ID
  static Future<bool> deleteLaporan(int id) async {
    try {
      final url = Connection.buildUrl('$_endpoint/$id');
      final response = await http.delete(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      print('Error in deleteLaporan: $e');
      return false;
    }
  }
}