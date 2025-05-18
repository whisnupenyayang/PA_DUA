import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';

class ForumProvider extends GetConnect {
  final String url = '/forum'; // API endpoint for forums

  // Method for posting a new forum (with multipart for images)
  Future<Response> postForum({
    required String token,
    required String judulForum,
    required String deskripsiForum,
    String? imagePath,
  }) async {
    final url = Connection.buildUrl(this.url); // Ensure this is the correct URL
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';

    // Add text fields
    request.fields['title'] = judulForum;
    request.fields['deskripsi'] = deskripsiForum;

    // Add image file if provided
    if (imagePath != null && imagePath.isNotEmpty) {
      final mimeType = lookupMimeType(imagePath) ?? 'application/octet-stream';
      request.files.add(await http.MultipartFile.fromPath(
        'gambar', // Field name for the image in the API
        imagePath,
        contentType: MediaType.parse(mimeType),
      ));
    }

    try {
      // Send the multipart request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Convert the response to GetConnect's Response format
      return Response(
        statusCode: response.statusCode,
        body: jsonDecode(response.body),
        statusText: response.statusCode == 200 || response.statusCode == 201
            ? 'Success'
            : 'Failed',
      );
    } catch (e) {
      // Handle any errors during the request
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  // Fetch forum list with pagination
  Future<Response> getForum(int page, String? token) {
    final url = Connection.buildUrl('$this.url?limit=5&page=$page');
    return get(url, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
    });
  }

  // Fetch forum detail by ID
  Future<Response> getForumDetail(int id, String? token) {
    final url = Connection.buildUrl('$this.url/$id');
    return get(url, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
    });
  }

  // Fetch comments for a forum
  Future<Response> getKomentar(int id) {
    final url = Connection.buildUrl('/forumKomen/$id');
    return get(url);
  }

  // Post comment to a forum
  Future<Response> postKomentar(String komentar, String? token, int forum_id) {
    final url = Connection.buildUrl('/forum/$forum_id/komentar');
    final body = json.encode({"komentar": komentar, "forum_id": forum_id});
    return post(url, body, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
  }
}
