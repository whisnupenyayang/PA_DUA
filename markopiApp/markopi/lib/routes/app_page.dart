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
<<<<<<< HEAD
    GetPage(
      name: RouteName.budidaya + '/:jenis_kopi',
      page: () => TipeBudidaya(),
      binding: BudidayaBinding(),
    ),
    GetPage(
      name: RouteName.forumkomen + '/:id',
      page: () => ForumKomentar(),
    )
=======
>>>>>>> b7d988b14595090ff7890c8ed522634798f81a43
  ];
}
