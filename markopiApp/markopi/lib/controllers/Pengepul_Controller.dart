import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:markopi/models/Pengepul_Model.dart';
import 'package:markopi/models/RataRataHargaKopi_Model.dart';
import 'package:markopi/providers/Pengepul_Providers.dart';
import 'package:markopi/service/token_storage.dart';

class PengepulController extends GetxController {
  final pengepulProvider = PengepulProviders();

  var pengepul = <Pengepul>[].obs;
  var rataRataHargaKopi = <RataRataHargakopi>[].obs;
  var detailPengepul = Pengepul.empty().obs;

  // Tambahan properti agar bisa dipakai di tampilan
  var pengepulByUser = <Pengepul>[].obs;
  var allPengepul = <Pengepul>[].obs;

  Future<void> fetchRataRataHarga(String jenis_kopi, String tahun) async {
    final response =
        await pengepulProvider.getHargaRataRataKopi(jenis_kopi, tahun);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body['data'];
      rataRataHargaKopi.value =
          data.map((e) => RataRataHargakopi.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil data rata-rata harga kopi');
    }
  }

  Future<void> fetchPengepul() async {
    final response = await pengepulProvider.getPengepul();
    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;
      pengepul.value = data.map((e) => Pengepul.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil data pengepul');
    }
  }

  Future<void> fetchPengepulByUser([int? userId]) async {
    final String? token = await TokenStorage.getToken();
    if (token == null) {
      Get.snackbar('Error', 'Anda belum login');
      return;
    }

    final response = await pengepulProvider.getDataPengepulByid(token);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;
      pengepulByUser.value = data.map((e) => Pengepul.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil data pengepul user');
    }
  }

  Future<void> fetchAllPengepul() async {
    final response = await pengepulProvider.getPengepul();
    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;
      allPengepul.value = data.map((e) => Pengepul.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil semua pengepul');
    }
  }

  Future<void> tambahDataPengepul(
    String nama_toko,
    String jenis_kopi,
    int harga,
    String nomor_telepon,
    String alamat,
    File nama_gambar,
  ) async {
    final String? token = await TokenStorage.getToken();

    if (token == null) {
      return print("Token kosong");
    }

    final response = await pengepulProvider.postPengepul(
        nama_toko, jenis_kopi, harga, nomor_telepon, alamat, nama_gambar, token);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      Get.snackbar('Berhasil', responseBody['message'] ?? 'Upload berhasil');
    } else {
      final errorBody = jsonDecode(response.body);
      Get.snackbar('Error', errorBody['message'] ?? 'Upload gagal');
    }
  }

  Future<void> fetcPengepulDetail(int id) async {
    final response = await pengepulProvider.getPengepulDetail(id);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.body;
      detailPengepul.value = Pengepul.fromJson(data);
    } else {
      Get.snackbar('Gagal', 'Gagal mengambil detail pengepul');
    }
  }

  Future<void> tambahPengepul({
    required String nama,
    required String alamat,
    required String harga,
    required File gambar,
    required String telepon,
    required String jenisKopi,
  }) async {
    final String? token = await TokenStorage.getToken();

    if (token == null) {
      Get.snackbar("Error", "Token tidak ditemukan");
      return;
    }

    final response = await pengepulProvider.postPengepul(
      nama, // nama_toko
      jenisKopi, // jenis_kopi
      int.parse(harga),
      telepon, // nomor_telepon
      alamat,
      gambar,
      token,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      Get.snackbar('Berhasil', responseBody['message'] ?? 'Upload berhasil');
      fetchPengepulByUser(); // refresh data user pengepul
      fetchAllPengepul();    // refresh semua pengepul
    } else {
      final errorBody = jsonDecode(response.body);
      Get.snackbar('Gagal', errorBody['message'] ?? 'Upload gagal');
    }
  }
}
