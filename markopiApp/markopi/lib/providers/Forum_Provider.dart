import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';

class ForumProvider extends GetConnect {
  final String url = '/forum';

  Future<Response> getForum(int page, String? token) {
    return get(Connection.buildUrl(url + '?limit=5&page=$page'), headers: {
      'Authorization': 'Bearer $token',
    });
  }

  Future<Response> getKomentar(int id) {
    return get(Connection.buildUrl('/forumKomen/$id'));
  }
}
