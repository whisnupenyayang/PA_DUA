// main.dart
import 'package:belajar_flutter/artikel/artikel.dart';

// import 'package:belajar_flutter/beranda.dart';
import 'package:belajar_flutter/forum/detail_forum.dart';
import 'package:belajar_flutter/fasilitator/add_artikel.dart';
import 'package:belajar_flutter/fasilitator/artikel_saya.dart';
import 'package:belajar_flutter/fasilitator/beranda_fasilitator.dart';
import 'package:belajar_flutter/fasilitator/fasilitator_list_artikel.dart';
import 'package:belajar_flutter/fasilitator/forum_fasilitator.dart';
import 'package:belajar_flutter/fasilitator/notifikasi_fasilitator.dart';
import 'package:belajar_flutter/forgot_password.dart';
import 'package:belajar_flutter/forum/forum_saya.dart';
import 'package:belajar_flutter/budidaya/hama/hama.dart';
import 'package:belajar_flutter/komunitas.dart';
import 'package:belajar_flutter/artikel/list_artikel.dart';
import 'package:belajar_flutter/autentikasi/Register.dart';
import 'package:belajar_flutter/minuman/list_minuman.dart';
import 'package:belajar_flutter/minuman/minuman.dart';
import 'package:belajar_flutter/notifikasi.dart';
import 'package:belajar_flutter/pasca_panen/pasca_panen.dart';
import 'package:belajar_flutter/budidaya/pemangkasan/pemangkasan.dart';
import 'package:belajar_flutter/pengajuan/pengajuan_saya.dart';
import 'package:belajar_flutter/budidaya/pengelolaan_penaung/pengelolaan_penaung.dart';
import 'package:belajar_flutter/budidaya/penanaman/penanaman_page.dart';
import 'package:belajar_flutter/panen/detail_ciri_buah_kopi_page.dart';
import 'package:belajar_flutter/panen/detail_pemetikan_page.dart';
import 'package:belajar_flutter/panen/detail_sortasi_buah.dart';
import 'package:belajar_flutter/pasca_panen/fermentasi_kering.dart';
import 'package:belajar_flutter/pasca_panen/fermentasi_mekanis.dart';
import 'package:belajar_flutter/budidaya/pembibitan/pembibitan.dart';
import 'package:belajar_flutter/budidaya/penanaman_penaung/penanaman_penaung_page.dart';
import 'package:belajar_flutter/petani/Addforum.dart';
import 'package:belajar_flutter/petani/beranda_petani.dart';
import 'package:belajar_flutter/petani/petani_list_artikel.dart';
import 'package:belajar_flutter/petani/petani_list_komunitas.dart';
import 'package:belajar_flutter/petani/profile._petani.dart';
import 'package:belajar_flutter/profile.dart';

import 'package:belajar_flutter/reset_password.dart';
import 'package:belajar_flutter/pengajuan/status_pengajuan_page.dart';
import 'package:belajar_flutter/budidaya/unggul/unggul.dart';
import 'package:belajar_flutter/budidaya/pemupukan/pemupukan.dart';
import 'package:belajar_flutter/update_profil.dart';
import 'package:flutter/material.dart';
import 'budidaya/budidaya.dart';
import 'budidaya/pemilihan_lahan/pemilihan_lahan.dart';
import 'budidaya/kesesuaian_lahan/kesesuaian_lahan_page.dart';
import 'budidaya/persiapan_lahan/persiapan_lahan_page.dart';
import 'panen/panen.dart';
import 'package:belajar_flutter/autentikasi/login_page.dart';
import 'pengajuan/pengajuan_page.dart';
import 'pengajuan/tambah_pengajuan_page.dart';
import 'splashscreen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'autentikasi/auth_manager_page.dart';
import 'package:belajar_flutter/newberanda/beranda.dart';
// import 'package:belajar_flutter/Login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // Inisialisasi locale data
  await AuthManager.loadUser(); // Muat status login
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Set ProsesBudidayaPage sebagai halaman utama
      // home: Login(),
      routes: {
        '/beranda': (context) => Beranda(),
        // '/kedai_kopi': (context) => MapScreen(),\
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/reset_password': (context) => ResetPasswordPage(),

        //budidaya
        '/budidaya': (context) => InformationPage(),
        '/pemilihan_lahan': (context) => PemilihanLahanPage(),
        '/kesesuaian_lahan': (context) => KesesuaianLahanPage(),
        '/persiapan_lahan': (context) => PersiapanLahanPage(),
        '/panen': (context) => PanenPage(),
        '/penanaman_penaung': (context) => PenanamanPenaungPage(),
        '/bahan_tanam_unggul': (context) => UnggulPage(),
        '/pembibitan': (context) => PembibitanPage(),
        '/penanaman': (context) => PenanamanPage(),
        '/pemupukan': (context) => PemupukanPage(),
        '/pemangkasan': (context) => PemangkasanPage(),
        '/pengelolaan_penaung': (context) => PengelolaanPage(),
        '/pengendalian_hama': (context) => HamaPage(),

        //Panen
        '/pemetikan': (context) => DetailPemetikanPage(),
        '/ciri_buah_kopi': (context) => DetailCiriBuahKopiPage(),
        '/sortasi_buah': (context) => DetailSortasiPage(),
        '/pasca_panen': (context) => PascaPanenPage(),

        //Pasca Panen
        '/fermentasi_kering': (context) => FermentasiKeringPage(),
        '/fermentasi_mekanis': (context) => FermentasiMekanisPage(),

        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationScreen(),
        '/pengajuan': (context) => PengajuanPage(),
        '/addpengajuan': (context) => TambahPengajuanPage(),
        '/statuspengajuan': (context) => StatusPengajuanPage(),
        '/article': (context) => ArticlePage(
              articleData: ArticlePage,
            ),
        '/list_artikel': (context) => ListArtikel(),
        '/minuman': (context) => MinumanPage(
              minumanData: MinumanPage,
            ),
        '/list_minuman': (context) => ListMinuman(),
        '/forum': (context) => DetailKomunitasPage(
              forumData: DetailKomunitasPage,
            ),
        '/forum_saya': (context) => ForumSayaPage(),

        //fasilitator
        '/add_artikel': (context) => AddArticle(),
        '/beranda_fasilitator': (context) => BerandaFasilitator(),
        '/profil': (context) => profil(),
        '/Komunitas': (context) => Komunitas(),
        '/fasilitator_list_artikel': (context) => ListArtikelFasilitator(),
        '/fasilitator_list_forum': (context) => ForumFasilitator(),
        '/artikel_saya': (context) => ArtikelSayaPage(),
        '/notifikasi_fasilitator': (context) => notifikasiFasilitator(),

        //petani
        '/beranda_petani': (context) => BerandaPetani(),
        '/petani_list_forum': (context) => ListForumPetani(),
        '/petani_list_artikel': (context) => ListArtikelPetani(),
        '/profil_petani': (context) => ProfilePetani(),
        '/Addforum': (context) => AddForum(),
        '/notifikasi_petani': (context) => notifikasi(),
        '/update_profil_petani': (context) {
          final userId = AuthManager.getUserId();
          if (userId != null) {
            return UpdateProfilePage(userId: userId.toString());
          } else {
            return LoginPage(); // atau rute lain jika userId null
          }
        },
        '/pengajuan_saya': (context) => PengajuanSayaPage(),
      },
    );
  }
}
