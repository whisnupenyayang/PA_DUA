import 'package:get/get.dart';
// import 'package:markopi/view/Admin/Beranda/Beranda.dart';
import 'package:markopi/view/Beranda/Beranda.dart';
import 'package:markopi/view/Budidaya/Jenis_kopi.dart';
import 'package:markopi/view/forum/ListForum.dart';
import 'package:markopi/view/pengepul/ListPengepul.dart';
import 'package:markopi/view/pengepul/listPengepul2.dart';

import './route_name.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.beranda,
      page: () => Beranda(),
    ),
    GetPage(
      name: RouteName.pengepul,
      page: () => ListPengepul(),
    ),
    GetPage(
      name: RouteName.forum,
      page: () => ListForum(),
    ),
    GetPage(
      name: RouteName.budidaya,
      page: () => Budidaya(),
    ),
  ];
}
