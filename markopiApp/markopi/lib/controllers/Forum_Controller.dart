import 'package:get/get.dart';
import 'package:markopi/models/Forum_Model.dart';
import 'package:markopi/models/Komentar_Forum_Model.dart';
import 'package:markopi/providers/Forum_Provider.dart';
import 'package:markopi/service/token_storage.dart';

class ForumController extends GetxController {
  var forum = <Forum>[].obs;
  var page = 1;
  var isLoading = false.obs;
  var hasMore = true;
  var komentarForum = <KomentarForum>[].obs;
  var forumDetail = Rxn<Forum>(); // Untuk detail forum

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

    print('fetchForum status: ${response.statusCode}');
    print('fetchForum body: ${response.body}');

    if (response.statusCode == 200) {
      final data = response.body['data'];
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

    print('fetchKomentar status: ${response.statusCode}');
    print('fetchKomentar body: ${response.body}');

    if (response.statusCode == 200) {
      final data = response.body['data'];
      if (data is List) {
        komentarForum.value = data.map((item) => KomentarForum.fromJson(item)).toList();
      } else {
        komentarForum.value = [];
        print('Data komentar bukan list atau kosong');
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
    print('buatKomentar status: ${response.statusCode}');
    print('buatKomentar body: ${response.body}');

    if (response.statusCode == 200) {
      Get.snackbar('Berhasil', 'Komentar berhasil ditambahkan');
      await fetchKomentar(forum_id); // Refresh komentar
    } else {
      Get.snackbar('Gagal', 'Gagal menambahkan komentar');
    }
  }

  Future<void> fetchForumDetail(int id) async {
    final String? token = await TokenStorage.getToken();

    final response = await forumProvider.getForumDetail(id, token);

    print('fetchForumDetail status: ${response.statusCode}');
    print('fetchForumDetail body: ${response.body}');

    if (response.statusCode == 200) {
      final data = response.body['data'];
      if (data != null) {
        try {
          forumDetail.value = Forum.fromJson(data);
        } catch (e) {
          print('Error parsing forum detail: $e');
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
}
