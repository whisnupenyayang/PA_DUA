import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

class PengepulProviders extends GetConnect {
  Future<Response> getPengepul() {
    return get(Connection.buildUrl('/pengepul'));
  }

  Future<Response> getHargaRataRataKopi(String jenis_kopi, String tahun) {
    return get(Connection.buildUrl('/hargaratarata/$jenis_kopi/$tahun'));
  }

  Future<Response> getDataPengepulByid(String token) async {
    return get(Connection.buildUrl('/pengepulByuser'),
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<http.Response> postPengepul(
      String nama_toko,
      String jenis_kopi,
      int harga,
      String nomor_telepon,
      String alamat,
      File nama_gambar,
      String token) async {
    var uri = Uri.parse(Connection.buildUrl('/pengepul'));
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';

    // Tambahkan field form
    request.fields['nama_toko'] = nama_toko;
    request.fields['jenis_kopi'] = jenis_kopi;
    request.fields['harga'] = harga.toString();
    request.fields['nomor_telepon'] = nomor_telepon;
    request.fields['alamat'] = alamat;

    // Tambahkan file
    request.files.add(await http.MultipartFile.fromPath(
      'nama_gambar',
      nama_gambar.path,
    ));

    // Kirim request
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  Future<Response> getPengepulDetail(int id) async {
    return get(Connection.buildUrl('/pengepul/detail/$id'));
  }
}
