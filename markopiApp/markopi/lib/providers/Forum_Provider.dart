import 'package:get/get.dart';

class ForumProvider extends GetConnect {
  final String url = 'http://10.0.2.2:8000/api';

  Future<Response> getForum() {
    return get('$url/forum');
  }
}
