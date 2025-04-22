class Connection {
  static const String apiUrl =
      // 'https://www.markopi.cloud/api'; // URL API Laravel yang sudah di-hosting
      // 'http://192.168.66.151:8000/api'; // URL API Andoroid
      'http://10.0.2.2:8000/api'; // URL API Laravel local

  // Fungsi untuk menggabungkan URL API dengan endpoint tertentu
  static String buildUrl(String endpoint) {
    return apiUrl + endpoint;
  }
}
