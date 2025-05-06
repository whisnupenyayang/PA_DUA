import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';

class PengepulProviders extends GetConnect {
  Future<Response> getPengepul() {
    return get(Connection.buildUrl('/pengepul'));
  }

  Future<Response> getHargaRataRataKopi(String jenis_kopi, String tahun) {
    return get(Connection.buildUrl('/hargaratarata/$jenis_kopi/$tahun'));
  }
}
