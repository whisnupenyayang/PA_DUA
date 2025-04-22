import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';

class ForumProvider extends GetConnect {
  final String url = '/forum';

  Future<Response> getForum() {
    return get(Connection.buildUrl(url));
  }

  Future<Response> getKomentar(int id) {
    return get(Connection.buildUrl('/forumKomen/$id'));
  }
}
