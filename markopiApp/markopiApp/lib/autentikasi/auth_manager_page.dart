import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../connection.dart';

class Users {
  int id;
  String username;
  String email;
  String role;
  String namaLengkap;
  String tanggalLahir;
  String jenisKelamin;
  String provinsi;
  String kabupaten;
  String noTelp;

  Users({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.namaLengkap,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.provinsi,
    required this.kabupaten,
    required this.noTelp,
  });
}

class AuthManager {
  static int? userId;
  static Users? loggedInUser;

  static Future<void> login(int id, String username, String role) async {
    userId = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', id);
    await prefs.setString('username', username);
    await prefs.setString('role', role);
    await loadUser();
  }

  static Future<void> logout() async {
    userId = null;
    loggedInUser = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('role');
  }

  static bool isLoggedIn() {
    return userId != null;
  }

  static Users? getUser() {
    return loggedInUser;
  }

  static int? getUserId() {
    return userId;
  }

  static String? getUsername() {
    return loggedInUser?.username;
  }

  static Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedUserId = prefs.getInt('userId');
    if (storedUserId != null) {
      userId = storedUserId;
      await fetchUserData(storedUserId);
    }
  }

  static Future<void> fetchUserData(int id) async {
    final response =
        await http.get(Uri.parse('${Connection.buildUrl('/getUserById/')}$id'));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['data'] != null) {
        var data = responseData['data'];
        loggedInUser = Users(
          id: id,
          username: data['username'] ?? '',
          email: data['email'] ?? '',
          role: data['role'] ?? '',
          namaLengkap: data['nama_lengkap'] ?? '',
          tanggalLahir: data['tanggal_lahir'] ?? '',
          jenisKelamin: data['jenis_kelamin'] ?? '',
          provinsi: data['provinsi'] ?? '',
          kabupaten: data['kabupaten'] ?? '',
          noTelp: data['no_telp'] ?? '',
        );
      } else {
        throw Exception('Data user tidak ditemukan');
      }
    } else {
      throw Exception('Gagal memuat data user');
    }
  }

  static Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }
}
