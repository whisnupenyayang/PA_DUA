class Iklan {
  final int idIklan;
  final String judulIklan;
  final String deskripsiIklan;
  final String gambar;
  final String link;

  Iklan({
    required this.idIklan,
    required this.judulIklan,
    required this.deskripsiIklan,
    required this.gambar,
    required this.link,
  });

  factory Iklan.fromJson(Map<String, dynamic> json) {
    return Iklan(
      idIklan: json['id_iklan'],
      judulIklan: json['judul_iklan'],
      deskripsiIklan: json['deskripsi_iklan'],
      gambar: json['gambar'],
      link: json['link'],
    );
  }
}
