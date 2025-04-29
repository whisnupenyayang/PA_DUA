import 'package:get/get.dart';
import 'package:markopi/models/Budidaya_Model.dart';
import 'package:markopi/models/Forum_Model.dart';
import 'package:markopi/models/Komentar_Forum_Model.dart';
import 'package:markopi/providers/Budidaya_Provider.dart';
import 'package:markopi/providers/Forum_Provider.dart';
import 'dart:convert';

import 'package:markopi/service/token_storage.dart';

class ForumController extends GetxController {
  var forum = <Forum>[].obs;
  var page = 1;
  var isLoading = false.obs;
  var hasMore = true;
  var komentarForum = <KomentarForum>[].obs;

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
    print(token);

    final response = await forumProvider.getForum(page, token);

    if (response.statusCode == 200) {
      print('ini jalan');
      final data = response.body['data'];

      if (data != null && data is List) {
        final List<Forum> fetchedForums =
            data.map((item) => Forum.fromJson(item)).toList();

        if (fetchedForums.length < 5) {
          hasMore = false;
        } else {
          page++;
        }

        forum.addAll(fetchedForums);
      } else {
        hasMore = false;
        print("DATA TIDAK LIST atau NULL");
      }
    } else {
      Get.snackbar('eror', 'data gagal diambil');
    }

    isLoading.value = false;
  }

  Future<void> fetchKomentar(int id) async {
    final response = await forumProvider.getKomentar(id);
    if (response.statusCode == 200) {
      final dynamic data = response.body['data'];
      print("ISI DATA: $data");
      print("TIPE DATA: ${data.runtimeType}");
      if (data is List) {
        komentarForum.value =
            data.map((item) => KomentarForum.fromJson(item)).toList();
      } else {
        komentarForum.value = [];
        print('Data bukan list atau kosong.');
      }
    } else {
      print("apasi ${response.statusCode} ");
      Get.snackbar('Error', 'gagal mengambil data');
    }
  }
}
