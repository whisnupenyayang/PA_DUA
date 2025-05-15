import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';
import 'dart:convert';

class ForumProvider extends GetConnect {
  final String url = '/forum';

  Future<Response> getForum(int page, String? token) {
    return get(Connection.buildUrl(url + '?limit=5&page=$page'), headers: {
      if (token != null) 'Authorization': 'Bearer $token',
    });
  }

  Future<Response> getForumDetail(int id, String? token) {
    return get(Connection.buildUrl('$url/$id'), headers: {
      if (token != null) 'Authorization': 'Bearer $token',
    });
  }

  Future<Response> getKomentar(int id) {
    return get(Connection.buildUrl('/forumKomen/$id'));
  }

  Future<Response> postKomentar(String komentar, String? token, int forum_id) {
    final body = json.encode({"komentar": komentar, "forum_id": forum_id});
    return post(Connection.buildUrl('/forum/$forum_id/komentar'), body,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });
  }
}
