import 'package:get/get.dart';
import 'package:markopi/providers/Connection.dart';

class BudidayaProvider extends GetConnect {
  final String url = 'http://10.0.2.2:8000/api';

  Future<Response> getJenisKopi() {
    return get('$url/ujicoba');
  }

  Future<Response> getTipeBudidaya(int id) {
    return get(Connection.buildUrl('/ujicoba/$id'));
  }
}
