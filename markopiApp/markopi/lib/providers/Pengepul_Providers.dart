import 'package:get/get.dart';

class PengepulProviders extends GetConnect {
  final String url = 'http://10.0.2.2:8000/api';

  Future<Response> getPosts() {
    return get('$url/posts');
  }
}
