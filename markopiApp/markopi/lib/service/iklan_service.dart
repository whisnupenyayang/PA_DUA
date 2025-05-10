import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/iklan.dart';
import '../providers/connection.dart'; // Sesuaikan path kalau pakai modular

class IklanService {
  static const String _endpoint = '/iklans';

  static Future<List<Iklan>> getAllIklan() async {
    try {
      final url = Connection.buildUrl(_endpoint);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        List<dynamic> data = jsonBody['data']; // ⬅️ Ambil dari "data"
        return data.map((json) => Iklan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load iklan data');
      }
    } catch (e) {
      throw Exception('Error fetching iklan: $e');
    }
  }
}
