import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';

class ArtikelProvider extends GetConnect {
  final String url = 'http://10.0.2.2:8000/api';

  Future<Response> getPosts() {
    return get(Connection.buildUrl('/artikel'));
  }
}
