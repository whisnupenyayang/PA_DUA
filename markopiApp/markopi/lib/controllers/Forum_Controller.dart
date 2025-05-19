import 'dart:convert';
import 'package:get/get.dart';
import 'package:markopi/models/Forum_Model.dart';
import 'package:markopi/models/Komentar_Forum_Model.dart';
import 'package:markopi/providers/Forum_Provider.dart';
import 'package:markopi/service/token_storage.dart';

class ForumController extends GetxController {
  var forum = <Forum>[].obs;
  var page = 1;
  var isLoading = false.obs;
  RxBool hasMore = true.obs;
  var komentarForum = <KomentarForum>[].obs; // List of comments for a forum
  var forumDetail = Rxn<Forum>(); // Detail of the specific forum

  final forumProvider = ForumProvider();

  @override
  void onClose() {
    komentarForum.clear();
    super.onClose();
  }

  // Fetching forum list with pagination
  

  // Fetching comments for a specific forum based on forum_id
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

  // Fetching detailed information for a specific forum by id
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

  // Adding a comment to a forum
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
}
