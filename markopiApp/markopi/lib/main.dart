import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/app_page.dart';
import 'package:markopi/service/User_Storage.dart';
import 'package:markopi/test.dart';
import 'package:markopi/view/Budidaya/Jenis_Tahap_Budidaya.dart';
import 'package:markopi/view/Budidaya/Jenis_Tahap_Budidaya_Detail.dart';
import 'package:markopi/view/Budidaya/Jenis_kopi.dart';
import 'package:markopi/view/HargaKopi/ListPengepulFinal.dart';
import 'package:markopi/view/Laporan/LaporanPage.dart';
import 'package:markopi/view/Login/login.dart';
import 'package:markopi/view/Profile/Profile.dart';
import 'package:markopi/view/component/MyBottomNavigation.dart';
import 'package:markopi/view/forum/ForumKomentar.dart';
import 'package:markopi/view/HargaKopi/PengepulDetail.dart';

import './view/Beranda/Beranda.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDateFormatting();

  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBottomNavigationBar(), // Gunakan MyBottomNavigationBar di sini
      getPages: AppPages.pages,
    );
  }
}
