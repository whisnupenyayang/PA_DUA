import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:markopi/providers/Connection.dart';
import 'package:markopi/service/token_storage.dart';

class IncomeController {
  static Future<bool> kirimPendapatan({
    required String jenisKopi,
    required String tempatJual,
    required String tanggal,
    required String banyakKopi,
    required String hargaKopi,
  }) async {
    try {
      final String? token = await TokenStorage.getToken();
      if (token == null) {
        Get.snackbar("Gagal", "Anda Belum Login");
        return false;
      }

      final url = Uri.parse("${Connection.buildUrl("/pendapatan/store/${1}")}");

      final now = DateTime.now();
      final String tanggalSekarang =
          "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      final int hargaKopiInt = int.tryParse(hargaKopi) ?? 0;
      final int banyakKopiInt = int.tryParse(banyakKopi) ?? 0;
      final body = {
        "kebun_id": 1,
        "jenis_kopi": jenisKopi,
        "tempat_penjualan": tempatJual,
        "tanggal_panen": tanggal,
        "tanggal_penjualan": tanggalSekarang,
        "berat_kg": banyakKopi,
        "harga_per_kg": hargaKopi,
        "total_pendapatan": hargaKopiInt * banyakKopiInt,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );

      final responseData = json.decode(response.body);
      final status = responseData['status'];

      if (status == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> kirimPengeluaran({
    required String jenisPengeluaran,
    required String jumlah,
  }) async {
    try {
      final String? token = await TokenStorage.getToken();
      if (token == null) {
        Get.snackbar("Gagal", "Anda Belum Login");
        return false;
      }
      final url =
          Uri.parse("${Connection.buildUrl("/pengeluaran/store/${1}")}");
      
      final now = DateTime.now();
      final String tanggalSekarang =
          "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      final body = {
        "kebun_id": 1,
        "deskripsi_biaya": jenisPengeluaran,
        "nominal": jumlah,
        "tanggal": tanggalSekarang,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );

      final responseData = json.decode(response.body);
      debugPrint(response.body);
      final status = responseData['status'];

      if (status == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
