class Toko {
  final int id;
  final String namaToko;
  final String lokasi;
  final String jamOperasional;
  final String fotoToko;

  Toko({
    required this.id,
    required this.namaToko,
    required this.lokasi,
    required this.jamOperasional,
    required this.fotoToko,
  });

  // Membuat factory method untuk konversi JSON ke objek Toko
  factory Toko.fromJson(Map<String, dynamic> json) {
    return Toko(
      id: json['id'] ?? 0, // Kasih default 0 kalau null
      namaToko: json['nama_toko'] ?? '', // Kasih default empty string
      lokasi: json['lokasi'] ?? '',
      jamOperasional: json['jam_operasional'] ?? '',
      fotoToko: json['foto_toko'] ?? '',
    );
  }
}
