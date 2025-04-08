import 'package:intl/intl.dart';

class Minuman {
  final int id;
  final String namaMinuman;
  final String bahanMinuman;
  final String langkahMinuman;
  final String tanggal;
  final String creditGambar;
  final List<String> imageUrls;

  Minuman({
    required this.id,
    required this.namaMinuman,
    required this.bahanMinuman,
    required this.langkahMinuman,
    required this.tanggal,
    required this.creditGambar,
    required this.imageUrls,
  });

  factory Minuman.fromJson(Map<String, dynamic> json) {
    List<dynamic> images = json['images'];
    List<String> imageUrls =
        images.map((image) => image['url'] as String).toList();

    DateTime createdAt = DateTime.parse(json['created_at']);
    final formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    final formattedDate = formatter.format(createdAt);

    return Minuman(
      id: json['id_minumans'],
      namaMinuman: json['nama_minuman'],
      bahanMinuman: json['bahan_minuman'],
      langkahMinuman: json['langkah_minuman'],
      tanggal: formattedDate,
      creditGambar: json['credit_gambar'],
      imageUrls: imageUrls,
    );
  }
}
