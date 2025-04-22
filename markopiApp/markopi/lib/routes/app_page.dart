import 'package:get/get.dart';
// import 'package:markopi/view/Admin/Beranda/Beranda.dart';
import 'package:markopi/view/Beranda/Beranda.dart';
import 'package:markopi/view/Budidaya/Jenis_kopi.dart';
import 'package:markopi/view/Budidaya/Tahap_Budidaya.dart';
import 'package:markopi/view/forum/ForumKomentar.dart';
import 'package:markopi/view/forum/ListForum.dart';
import 'package:markopi/view/pengepul/ListPengepul.dart';
import 'package:markopi/view/pengepul/listPengepul2.dart';
import 'package:markopi/binding/Budidaya_Binding.dart';

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
      page: () => BudidayaView(),
      binding: BudidayaBinding(),
    ),
    GetPage(
      name: RouteName.budidaya + '/:jenis_kopi',
      page: () => TipeBudidaya(),
      binding: BudidayaBinding(),
    ),
    GetPage(
      name: RouteName.forumkomen + '/:id',
      page: () => ForumKomentar(),
    )
  ];
}
