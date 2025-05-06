import 'package:get/get.dart';
import 'package:markopi/models/Pengepul_Model.dart';
import 'package:markopi/models/RataRataHargaKopi_Model.dart';
import 'package:markopi/providers/Pengepul_Providers.dart';

class PengepulController extends GetxController {
  var pengepul = <Pengepul>[].obs;
  var rataRataHargaKopi = <RataRataHargakopi>[].obs;

  final pengepulProvider = PengepulProviders();

  Future<void> fetchRataRataHarga(String jenis_kopi, String tahun) async {
    final response =
        await pengepulProvider.getHargaRataRataKopi(jenis_kopi, tahun);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body['data'];

      print(data);
      rataRataHargaKopi.value =
          data.map((e) => RataRataHargakopi.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil data');
    }
  }

  Future<void> fetchPengepul() async {
    final response = await pengepulProvider.getPengepul();

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;

      print(data);
      pengepul.value = data.map((e) => Pengepul.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Gagal mengambil data');
    }
  }
}
