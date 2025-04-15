import 'package:get/get.dart';
import 'package:markopi/models/Forum_Model.dart';
import 'package:markopi/providers/Forum_Provider.dart';
import 'dart:convert';

class ForumController extends GetxController {
  var forum = <Forum>[].obs;

  final forumProvider = ForumProvider();

  @override
  void onInit() {
    fetchForum();
    super.onInit();
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
}
