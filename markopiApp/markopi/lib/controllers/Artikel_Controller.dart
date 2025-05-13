import 'package:get/get.dart';
import 'package:markopi/providers/Artikel_Providers.dart';
import '../models/Artikel_Model.dart';

class ArtikelController extends GetxController {
  var artikel = <Artikel>[].obs;
  final artikelProvider = ArtikelProvider();

  @override
  void onInit() {
    fetchArtikel();
    super.onInit();
  }

  Future<void> fetchArtikel() async {
    try {
      final response = await artikelProvider.getPosts();

      print('STATUS CODE: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.body['data'];

        artikel.value = jsonData.map((e) => Artikel.fromJson(e)).toList();
        print('Jumlah artikel: ${artikel.length}');
      } else {
        Get.snackbar('Error', 'Gagal mengambil data: ${response.statusText}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      print('Error saat fetchArtikel: $e');
    }
  }
}
