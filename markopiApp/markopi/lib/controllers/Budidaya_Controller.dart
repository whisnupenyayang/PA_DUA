import 'package:get/get.dart';
import 'package:markopi/models/JenisKopi_Model.dart';
import 'package:markopi/providers/Budidaya_Provider.dart';
import 'package:markopi/models/Budidaya_Model.dart';

class BudidayaController extends GetxController {
  var jenisKopi = <JenisKopi>[].obs;
  var budidayaList = <Budidaya>[].obs;

  final budidayaProvider = BudidayaProvider();

  void onInit() {
    super.onInit(); // panggil duluan
    fetchJenisKopi();
  }

  @override
  void onClose() {
    budidayaList.clear(); // Membersihkan list saat controller dihancurkan
    super.onClose();
  }

  void fetchJenisKopi() async {
    final response = await budidayaProvider.getJenisKopi();
    if (response.statusCode == 200) {
      final List<dynamic> json = response.body;
      print(response.body);

      jenisKopi.value = json.map((item) => JenisKopi.fromJson(item)).toList();
    } else {
  
    }
  }

  Future<void> fetchBudidaya(String jenis_kopi) async {
    print(jenis_kopi);

    final response = await budidayaProvider.getTipeBudidaya(jenis_kopi);
    if (response.statusCode == 200) {
      final List<dynamic> json = response.body;
      print(response.body);
      budidayaList.value = json.map((item) => Budidaya.fromJson(item)).toList();
    } else {
    print('ajdosjodkaldksldjakdsos');

      
    }
  }
}
