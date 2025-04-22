import 'package:flutter/material.dart';
import 'package:markopi/controllers/Budidaya_Controller.dart';

class Budidaya {
  int id;
  String nama_tahapan;
  String  jenis_kopi;

  Budidaya({
    required this.id,
    required this.nama_tahapan,
    required this.jenis_kopi,
  });

  factory Budidaya.fromJson(Map<String, dynamic> json) {
    return Budidaya(
        id: json['id'],
        nama_tahapan: json['nama_tahapan'],
        jenis_kopi: json['jenis_kopi']);
  }
}
