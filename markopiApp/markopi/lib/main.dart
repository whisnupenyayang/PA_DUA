import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/app_page.dart';
import 'package:markopi/test.dart';
import 'package:markopi/view/Budidaya/Jenis_Tahap_Budidaya.dart';
import 'package:markopi/view/Budidaya/Jenis_Tahap_Budidaya_Detail.dart';
import 'package:markopi/view/Budidaya/Jenis_kopi.dart';
import 'package:markopi/view/Laporan/Laporan_Page.dart';
import 'package:markopi/view/Login/login.dart';
import 'package:markopi/view/forum/ForumKomentar.dart';
import 'package:markopi/view/pengepul/ListPengepul.dart';
import 'package:markopi/view/pengepul/listPengepul2.dart';
import './view/Beranda/Beranda.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Beranda(), // Menampilkan halaman utama
      getPages: AppPages.pages,
      // home: ListPengepul(),
    );
  }
}
