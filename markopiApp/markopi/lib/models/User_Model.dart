class User {
  final int id;
  final String namaLengkap;
  final String username;
  final String? email;
  final String? tanggalLahir;
  final String? jenisKelamin;
  final String? provinsi;
  final String? kabupaten;
  final String? noTelp;
  final String? role; // Menambahkan role jika diperlukan

  User({
    required this.id,
    required this.namaLengkap,
    required this.username,
    this.email,
    this.tanggalLahir,
    this.jenisKelamin,
    this.provinsi,
    this.kabupaten,
    this.noTelp,
    this.role,
  });

  // Factory constructor untuk membuat instance User dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_users'] ?? 0, // Penanganan default nilai 0 jika id tidak ada
      namaLengkap: json['nama_lengkap'] ?? '', // Default string kosong jika tidak ada
      username: json['username'] ?? '', // Default string kosong jika tidak ada
      email: json['email'], // Nilai nullable jika tidak ada
      tanggalLahir: json['tanggal_lahir'], // Nilai nullable jika tidak ada
      jenisKelamin: json['jenis_kelamin'], // Nilai nullable jika tidak ada
      provinsi: json['provinsi'], // Nilai nullable jika tidak ada
      kabupaten: json['kabupaten'], // Nilai nullable jika tidak ada
      noTelp: json['no_telp'], // Nilai nullable jika tidak ada
      role: json['role'], // Menyertakan role jika ada
    );
  }
}
