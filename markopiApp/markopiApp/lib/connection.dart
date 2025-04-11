class Connection {
  // Ganti ini kalau kamu mau pindah device
  static const bool isUsingPhysicalDevice = true;

  static String get apiUrl => isUsingPhysicalDevice
      ? 'http://192.168.82.244:8000/api' // IP laptop untuk HP asli
      : 'http://10.0.2.2:8000/api';      // Untuk emulator Android

  static String buildUrl(String endpoint) {
    return apiUrl + endpoint;
  }
}
