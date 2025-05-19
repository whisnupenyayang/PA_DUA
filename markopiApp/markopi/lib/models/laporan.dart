class Laporan {
  final int id;
  final String judulLaporan;
  final String? isiLaporan;
  final int userId;
  final String userName;

  Laporan({
    required this.id,
    required this.judulLaporan,
    this.isiLaporan,
    required this.userId,
    required this.userName,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['id'] ?? 0,
      judulLaporan: json['judul_laporan'] ?? '',
      isiLaporan: json['isi_laporan'] ?? '',
      userId: json['id_users'] ?? 0,
      userName:
          json['user'] != null ? json['user']['name'] ?? '' : '', // ✅ aman
    );
  }
}
