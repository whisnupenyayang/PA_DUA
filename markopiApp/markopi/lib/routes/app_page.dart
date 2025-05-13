import 'package:get/get.dart';
import 'package:markopi/view/Artikel/List_artikel.dart';
// import 'package:markopi/view/Admin/Beranda/Beranda.dart';
import 'package:markopi/view/Beranda/Beranda.dart';
import 'package:markopi/view/Budidaya/Jenis_Tahap_Budidaya.dart';
import 'package:markopi/view/Budidaya/Jenis_Tahap_Budidaya_Detail.dart';
import 'package:markopi/view/Budidaya/Jenis_kopi.dart';
import 'package:markopi/view/Budidaya/Tahap_Budidaya.dart';
import 'package:markopi/view/DataPengepulUser/FormTambahDataPengepul.dart';
import 'package:markopi/view/HargaKopi/ListPengepulFinal.dart';
import 'package:markopi/view/HargaKopi/PengepulDetail.dart';
import 'package:markopi/view/Login/login.dart';
import 'package:markopi/view/Profile/Profile.dart';
import 'package:markopi/view/DataPengepulUser/UserPengepu.dart';
import 'package:markopi/view/forum/ForumKomentar.dart';
import 'package:markopi/view/forum/ListForum.dart';
import 'package:markopi/view/toko/toko_kopi_page.dart';  // Import halaman Toko Kopi
import 'package:markopi/view/resep/resep_kopi_page.dart'; 
import 'package:markopi/binding/Budidaya_Binding.dart';
import './route_name.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.beranda,
      page: () => Beranda(),
    ),

    /*================Forum=================== */

    GetPage(
      name: RouteName.forum,
      page: () => ListForum(),
    ),
    GetPage(
      name: RouteName.forumkomen + '/:id',
      page: () => ForumKomentar(),
    ),

    /*================Budidaya=================== */
    GetPage(
      name: RouteName.kegiatan + '/:kegiatan/:jenis_kopi',
      page: () => TipeBudidaya(),
      binding: BudidayaBinding(),
    ),
    GetPage(
      name: RouteName.kegiatan + '/:kegiatan',
      page: () => BudidayaView(),
    ),
    GetPage(
      name: RouteName.kegiatan +
          '/:kegiatan/:jenis_kopi/jenistahapankegiatan/:id',
      page: () => JenisTahapBudidayaView(),
    ),
    GetPage(
      name: RouteName.kegiatan + '/jenistahapanbudidaya/detail/:id',
      page: () => JenisTahapBudidayDetailView(),
    ),

    /*================Autentikasi=================== */

    GetPage(
      name: RouteName.login,
      page: () => LoginView(),
    ),
    /*================Autentikasi=================== */

    GetPage(
      name: RouteName.profile,
      page: () => ProfileView(),
    ),
    GetPage(
      name: RouteName.profile + '/datapengepul',
      page: () => UserPengepulView(),
    ),

    /*================Pengepul=================== */
    GetPage(
      name: RouteName.pengepul,
      page: () => KopiPage(),
    ),

    /*================Toko Kopi=================== */
    GetPage(
      name: RouteName.pengepul + '/detail/:role',
      page: () => DetailPengepuldanPetani(),
    ),
    GetPage(
      name: RouteName.pengepul + '/tambahDataPengepul',
      page: () => TambahPengepulView(),
    ),

    /*================Artikel=================== */
    GetPage(
      name: RouteName.artikel,
      page: () => ListArtikel(),
    ),

    /*================Toko Kopi=================== */
    GetPage(
      name: RouteName.tokoKopi,
      page: () => TokoKopiPage(),  // Menambahkan halaman Toko Kopi
    ),

    /*================Resep Kopi=================== */
    GetPage(
      name: RouteName.resepKopi,
      page: () => ResepKopiPage(),  // Menambahkan halaman Resep Kopi
    ),
  ];
}
