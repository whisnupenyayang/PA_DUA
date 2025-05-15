import 'package:get/get.dart';
import './Connection.dart';
import 'dart:convert';

class AutentikasiProvider extends GetConnect {
  Future<Response> login(String username, String password) {
    final body = json.encode({"username": username, "password": password});

    return post(Connection.buildUrl('/login'), body);
  }

  Future<Response> logout(String token) async {
    return get(Connection.buildUrl('/logout'), headers: {
      'Authorization': 'Bearer $token',
    });
  }
}
