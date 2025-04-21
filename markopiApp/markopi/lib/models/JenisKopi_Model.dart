class JenisKopi {
  int id;
  String nama_kopi;

  JenisKopi({
    required this.id,
    required this.nama_kopi,
  });

  factory JenisKopi.fromJson(Map<String, dynamic> json) {
    return JenisKopi(
      id: json['id'],
      nama_kopi: json['nama_kopi'],
    );
  }
}
