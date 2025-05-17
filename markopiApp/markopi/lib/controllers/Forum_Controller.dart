import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:markopi/models/Forum_Model.dart';
import 'package:markopi/models/Komentar_Forum_Model.dart';
import 'package:markopi/providers/Forum_Provider.dart';
import 'package:markopi/service/token_storage.dart';
import 'package:http_parser/http_parser.dart';

class ForumController extends GetxController {
  var forum = <Forum>[].obs;
  var page = 1;
  var isLoading = false.obs;
  var hasMore = true;
  var komentarForum = <KomentarForum>[].obs;
  var forumDetail = Rxn<Forum>();

  final forumProvider = ForumProvider();

  @override
  void onClose() {
    komentarForum.clear();
    super.onClose();
  }

  Future<void> fetchForum() async {
    if (isLoading.value || !hasMore) return;

    isLoading.value = true;
    final String? token = await TokenStorage.getToken();

    final response = await forumProvider.getForum(page, token);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      if (data != null && data is List) {
        final fetchedForums = data.map((item) => Forum.fromJson(item)).toList();

        if (fetchedForums.length < 5) {
          hasMore = false;
        } else {
          page++;
        }
        forum.addAll(fetchedForums);
      } else {
        hasMore = false;
      }
    } else {
      Get.snackbar('Error', 'Gagal mengambil data forum');
    }
    isLoading.value = false;
  }

  Future<void> fetchKomentar(int id) async {
    final response = await forumProvider.getKomentar(id);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      if (data is List) {
        komentarForum.value = data.map((item) => KomentarForum.fromJson(item)).toList();
      } else {
        komentarForum.value = [];
      }
    } else {
      Get.snackbar('Error', 'Gagal mengambil komentar');
    }
  }

  Future<void> buatKomentar(String komentar, int forum_id) async {
    final String? token = await TokenStorage.getToken();

    if (token == null) {
      Get.snackbar('Error', 'Anda belum login');
      return;
    }

    final response = await forumProvider.postKomentar(komentar, token, forum_id);
    if (response.statusCode == 200) {
      Get.snackbar('Berhasil', 'Komentar berhasil ditambahkan');
      await fetchKomentar(forum_id);
    } else {
      Get.snackbar('Gagal', 'Gagal menambahkan komentar');
    }
  }

  Future<void> fetchForumDetail(int id) async {
    final String? token = await TokenStorage.getToken();

    final response = await forumProvider.getForumDetail(id, token);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      if (data != null) {
        try {
          forumDetail.value = Forum.fromJson(data);
        } catch (e) {
          forumDetail.value = null;
          Get.snackbar('Error', 'Gagal memproses data forum');
        }
      } else {
        forumDetail.value = null;
        Get.snackbar('Error', 'Data forum detail kosong');
      }
    } else {
      Get.snackbar('Error', 'Gagal mengambil detail forum');
    }
  }

  Future<void> tambahForum({
    required String judulForum,
    required String deskripsiForum,
    String? imagePath,
  }) async {
    final String url = 'http://192.168.150.244:8000/api/forum';
    final String? token = await TokenStorage.getToken();

    if (token == null) {
      Get.snackbar('Error', 'Anda belum login');
      return;
    }

    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['judulForum'] = judulForum;
      request.fields['deskripsiForum'] = deskripsiForum;

      if (imagePath != null && imagePath.isNotEmpty) {
        final mimeType = lookupMimeType(imagePath) ?? 'application/octet-stream';
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imagePath,
          contentType: MediaType.parse(mimeType),
        ));
      }

      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar('Berhasil', 'Pertanyaan berhasil dikirim');
      } else {
        Get.snackbar('Gagal', 'Terjadi kesalahan: ${response.statusCode}\n$resBody');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
