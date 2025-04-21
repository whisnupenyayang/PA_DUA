import 'package:get/get.dart';
import 'package:markopi/models/Budidaya_Model.dart';
import 'package:markopi/models/Forum_Model.dart';
import 'package:markopi/models/Komentar_Forum_Model.dart';
import 'package:markopi/providers/Budidaya_Provider.dart';
import 'package:markopi/providers/Forum_Provider.dart';
import 'dart:convert';

class ForumController extends GetxController {
  var forum = <Forum>[].obs;
  var komentarForum = <KomentarForum>[].obs;

  final forumProvider = ForumProvider();

  @override
  void onInit() {
    super.onInit();

    fetchForum();
  }

  @override
  void onClose() {
    komentarForum.clear();
    super.onClose();
  }

  void fetchForum() async {
    final response = await forumProvider.getForum();
    if (response.statusCode == 200) {
      final List<dynamic> forumList = response.body['data'];
      forum.value = forumList.map((item) => Forum.fromJson(item)).toList();
    } else {
      Get.snackbar('Error', 'Gagal Mengambil data');
    }
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
