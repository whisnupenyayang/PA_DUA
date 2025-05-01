import 'package:get/get.dart';
import 'package:markopi/providers/Autentikasi_Providers.dart';
import 'package:markopi/service/token_storage.dart';

class AutentikasiController extends GetxController {
  var token = RxnString(); 
  var namaLengkap = ''.obs;
  var idUser = 0.obs;
  var role = ''.obs;

  Future<void> login(String username, String password) async {
    final autentikasiProvider = AutentikasiProvider();

    final response = await autentikasiProvider.login(username, password);

    if (response.statusCode == 200) {
      final body = response.body; // GetX HTTP biasanya langsung JSON map

      if (body['success'] == true) {
        await TokenStorage.saveToken(body['token']);
      } else {
        Get.snackbar('Error', body['message'] ?? 'Login gagal');
      }
    } else {
      Get.snackbar('Error', 'Terjadi kesalahan server');
    }
  }
}
