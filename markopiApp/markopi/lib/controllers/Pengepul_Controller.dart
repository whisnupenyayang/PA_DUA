import 'dart:io';

import 'package:get/get.dart';
import 'package:markopi/models/Pengepul_Model.dart';
import 'package:markopi/models/RataRataHargaKopi_Model.dart';
import 'package:markopi/providers/Pengepul_Providers.dart';
import 'package:markopi/service/token_storage.dart';
import 'dart:convert';

class PengepulController extends GetxController {
  var pengepul = <Pengepul>[].obs;
  var rataRataHargaKopi = <RataRataHargakopi>[].obs;

  var detailPengepul = Pengepul.empty().obs;

  final pengepulProvider = PengepulProviders();

  Future<void> fetchRataRataHarga(String jenis_kopi, String tahun) async {
    final response =
        await pengepulProvider.getHargaRataRataKopi(jenis_kopi, tahun);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body['data'];

      print(data);
      rataRataHargaKopi.value =
          data.map((e) => RataRataHargakopi.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil data');
    }
  }

  Future<void> fetchPengepul() async {
    final response = await pengepulProvider.getPengepul();

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;

      print(data);
      pengepul.value = data.map((e) => Pengepul.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil data');
    }
  }

  Future<void> fetchPengepulByUser() async {
    final String? token = await TokenStorage.getToken();
    if (token == null) {
      Get.snackbar('Error', 'anda belum login');
      return;
    }
    final response = await pengepulProvider.getDataPengepulByid(token);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;
      print(data);
      pengepul.value = data.map((item) => Pengepul.fromJson(item)).toList();
    } else {
      Get.snackbar('errro', 'gagal terhubung kedatabase');
    }
  }

  Future<void> tambahDataPengepul(String nama_toko, String jenis_kopi,
      int harga, String nomor_telepon, String alamat, File nama_gambar) async {
    final String? token = await TokenStorage.getToken();

    if (token == null) {
      return print("token kosong");
    }
    final response = await pengepulProvider.postPengepul(nama_toko, jenis_kopi,
        harga, nomor_telepon, alamat, nama_gambar, token);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody['message']);
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
      print(data);
      detailPengepul.value = Pengepul.fromJson(data);
      print(detailPengepul);
    } else {
      Get.snackbar('gagal', 'gagalmengakmbil');
    }
  }

  Future<void> tambahPengepul({
    required String nama,
    required String alamat,
    required String harga,
    required File gambar,
  }) async {
    final String? token = await TokenStorage.getToken();

    if (token == null) {
      Get.snackbar("Error", "Token tidak ditemukan");
      return;
    }

    final response = await pengepulProvider.postPengepul(
      nama, // nama_toko
      "Arabika", // jenis_kopi (sementara hardcoded)
      int.parse(harga),
      "08123456789", // nomor_telepon (sementara hardcoded)
      alamat,
      gambar,
      token,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      Get.snackbar('Berhasil', responseBody['message'] ?? 'Upload berhasil');
      fetchPengepul(); // update daftar pengepul
    } else {
      final errorBody = jsonDecode(response.body);
      Get.snackbar('Gagal', errorBody['message'] ?? 'Upload gagal');
    }
  }
}
