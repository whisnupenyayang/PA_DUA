import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http; // package http
import 'package:http_parser/http_parser.dart';

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

  // Ubah ini supaya pakai http.MultipartRequest
  Future<Response> postForum({
    required String token,
    required String judulForum,
    required String deskripsiForum,
    String? imagePath,
  }) async {
    final uri = Uri.parse(Connection.buildUrl(url));

    var request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['judulForum'] = judulForum;
    request.fields['deskripsiForum'] = deskripsiForum;

    if (imagePath != null && imagePath.isNotEmpty) {
      final mimeTypeData = lookupMimeType(imagePath)?.split('/') ??
          ['application', 'octet-stream'];
      final file = await http.MultipartFile.fromPath(
        'image',
        imagePath,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      );
      request.files.add(file);
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Buat supaya Response GetConnect bisa terbentuk
      return Response(
        statusCode: response.statusCode,
        body: jsonDecode(response.body),
        request: http.Request('POST', uri) as dynamic,
      );
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }
}
