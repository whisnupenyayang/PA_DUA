class JenisTahapBudidaya {
  int id;
  String judul;
  String? deskripsi;
  int tahapan_budidaya_id;
  String created_at;
  String updated_at;

  JenisTahapBudidaya({
    required this.id,
    required this.judul,
    this.deskripsi,
    required this.tahapan_budidaya_id,
    required this.created_at,
    required this.updated_at,
  });

  factory JenisTahapBudidaya.fromJson(Map<String, dynamic> json) {
    return JenisTahapBudidaya(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      tahapan_budidaya_id: json['tahapan_budidaya_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  factory JenisTahapBudidaya.empty() {
    return JenisTahapBudidaya(
      id: 0,
      judul: '',
      deskripsi: '',
      tahapan_budidaya_id: 0,
      created_at: '',
      updated_at: '',
    );
  }
}
