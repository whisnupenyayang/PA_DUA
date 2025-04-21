import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';

class PengepulProviders extends GetConnect {
  final String url = '/posts';

  Future<Response> getPosts() {
    return get(Connection.buildUrl(url));
  }
}
