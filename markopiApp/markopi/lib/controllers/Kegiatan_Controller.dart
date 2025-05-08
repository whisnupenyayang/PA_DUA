import 'package:get/get.dart';
import 'package:markopi/models/Budidaya_Model.dart';
import 'package:markopi/models/JenisTahapKegiatan_Model.dart';
import 'package:markopi/models/TahapanKegiatan_Model.dart';
import 'package:markopi/providers/Kegiatan_Provider.dart';

class KegiatanController extends GetxController {
  var tahapanKegiatanList = <TahapanKegiatan>[].obs;
  var jenisTahapKegiatanList = <JenisTahapKegiatan>[].obs;
  var jenisTahapBudidayaDetail = JenisTahapKegiatan.empty().obs;

  final kegiatanProvider = KegiatanProvider();

  @override
  void onClose() {
    tahapanKegiatanList.clear();
    jenisTahapKegiatanList.clear();
    super.onClose();
  }

  Future<void> fetchKegiatan(String kegiatan, String jenis_kopi) async {
    print(kegiatan);

    final response =
        await kegiatanProvider.getTahapKegiatan(kegiatan, jenis_kopi);
    if (response.statusCode == 200) {
      final List<dynamic> json = response.body;
      tahapanKegiatanList.value =
          json.map((item) => TahapanKegiatan.fromJson(item)).toList();
      print(json);
    }
  }
}
