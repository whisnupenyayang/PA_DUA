import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/laporan_kebun.dart';
import '../providers/connection.dart';
import 'package:markopi/service/token_storage.dart';

class LaporanService {
  // Endpoint API untuk laporan
  static const String _endpoint = '/laporan/';

  // Fetch semua laporan
  static Future<LaporanResponse> getAllLaporans() async {
    Dio dio = Dio();
    final String? token = await TokenStorage.getToken();

    final url = Connection.buildUrl(_endpoint);

    // Print URL for debugging
    print('Fetching from URL: $url');

    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
        },
      ),
    );

    // Print response status code for debugging
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {

      final jsonResponse = response.data;

      final data = jsonResponse['data'];

      return LaporanResponse.fromJson(data);
    } else {
      throw Exception(
          'Failed to load laporan data: Status ${response.statusCode}');
    }
  }

  // Fetch laporan berdasarkan ID
  static Future<LaporanKebunModel?> getLaporanById(int id) async {
    try {
      final url = Connection.buildUrl('$_endpoint/$id');
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return LaporanKebunModel.fromJson(json.decode(
            response.body)['data']); // Sesuaikan dengan struktur response API
      } else {
        throw Exception('Failed to load laporan with ID: $id');
      }
    } catch (e) {
      print('Error in getLaporanById: $e');
      return null;
    }
  }

  // Menyimpan laporan baru
  static Future<Response<dynamic>> addLaporan(
      String namaKebun, String lokasi, String luasKebun) async {
    final String? token = await TokenStorage.getToken();

    final dio = Dio();

    return await dio.post(
      Connection.buildUrl('/laporan/store'),
      data: {
        'nama_kebun': namaKebun,
        'lokasi': lokasi,
        'luas_kebun': double.parse(luasKebun),
      },
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
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
