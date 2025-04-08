class PengajuanData {
  final int id;
  final String? fotoKtpUrl;
  final String? fotoSelfieUrl;
  final String? fotoSertifikatUrl;
  final String deskripsiPengalaman;
  final String status;

  PengajuanData({
    required this.id,
    this.fotoKtpUrl,
    this.fotoSelfieUrl,
    this.fotoSertifikatUrl,
    required this.deskripsiPengalaman,
    required this.status,
  });

  factory PengajuanData.fromJson(Map<String, dynamic> json) {
    return PengajuanData(
      id: int.parse(json['id_pengajuans'].toString()),
      fotoKtpUrl: json['foto_ktp_url'],
      fotoSelfieUrl: json['foto_selfie_url'],
      fotoSertifikatUrl: json['foto_sertifikat_url'],
      deskripsiPengalaman: json['deskripsi_pengalaman'],
      status: json['status'],
    );
  }
}
