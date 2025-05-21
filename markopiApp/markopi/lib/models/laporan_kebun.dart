class LaporanResponse {
  final List<LaporanKebunModel> laporan;
  final int totalProduktifitas;

  LaporanResponse({
    required this.laporan,
    required this.totalProduktifitas,
  });

  factory LaporanResponse.fromJson(Map<String, dynamic> json) {
    return LaporanResponse(
      laporan: (json['laporan'] as List)
          .map((item) => LaporanKebunModel.fromJson(item))
          .toList(),
      totalProduktifitas: json['total_produktifitas'] ?? 0,
    );
  }
}

class LaporanKebunModel {
  final int id;
  final String namaKebun;
  final String lokasi;
  final double luasKebun;
  final int totalPendapatan;
  final int totalPengeluaran;
  final int hasilProduktifitas;

  LaporanKebunModel({
    required this.id,
    required this.namaKebun,
    required this.lokasi,
    required this.luasKebun,
    required this.totalPendapatan,
    required this.totalPengeluaran,
    required this.hasilProduktifitas,
  });

  factory LaporanKebunModel.fromJson(Map<String, dynamic> json) {
    return LaporanKebunModel(
      id: json['id'],
      namaKebun: json['nama_kebun'],
      lokasi: json['lokasi'],
      luasKebun: json['luas_kebun'],
      totalPendapatan: json['total_pendapatan'],
      totalPengeluaran: json['total_pengeluaran'],
      hasilProduktifitas: json['hasil_produktifitas'],
    );
  }
}
