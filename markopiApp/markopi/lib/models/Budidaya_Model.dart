import 'package:flutter/material.dart';
import 'package:markopi/controllers/Budidaya_Controller.dart';

class Budidaya {
  int id;
  String nama_tahapan;
  int kopi_id;

  Budidaya({
    required this.id,
    required this.nama_tahapan,
    required this.kopi_id,
  });

  factory Budidaya.fromJson(Map<String, dynamic> json) {
    return Budidaya(
        id: json['id'],
        nama_tahapan: json['nama_tahapan'],
        kopi_id: json['kopi_id']);
  }
}
