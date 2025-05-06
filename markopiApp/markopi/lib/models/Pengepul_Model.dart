class Pengepul {
  int id;
  String nama_toko;
  String jenis_kopi;
  String nama_gambar;
  String url_gambar;
  int harga;
  String nomor_telepon;
  String alamat;

  Pengepul({
    required this.id,
    required this.nama_toko,
    required this.jenis_kopi,
    required this.nama_gambar,
    required this.url_gambar,
    required this.harga,
    required this.nomor_telepon,
    required this.alamat,
  });

  factory Pengepul.fromJson(Map<String, dynamic> json) {
    return Pengepul(
      id: json['id'],
      nama_toko: json['nama_toko'],
      jenis_kopi: json['jenis_kopi'],
      nama_gambar: json['nama_gambar'],
      url_gambar: json['url_gambar'],
      harga: json['harga'],
      nomor_telepon: json['nomor_telepon'],
      alamat: json['alamat'],
    );
  }
}
