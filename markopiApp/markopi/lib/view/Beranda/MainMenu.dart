import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/route_name.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final List<String> imageList = [
    'assets/images/budidaya.png',
    'assets/images/panen.png',
    'assets/images/pascapanen.png',
    'assets/images/laporan.png',
    'assets/images/tokokopi.png', // Gambar Toko Kopi
    'assets/images/resepkopi.png', // Gambar Resep Kopi
  ];

  final List<String> menuList = [
    'Budidaya',
    'Panen',
    'Pasca_Panen',
    'Laporan',
    'Toko_Kopi', // Menambahkan Toko Kopi
    'Resep_Kopi', // Menambahkan Resep Kopi
  ];

  final List<String> labelMenu = [
    'Budidaya',
    'Panen',
    'PascaPanen',
    'Laporan',
    'Toko Kopi', // Menambahkan label Toko Kopi
    'Resep Kopi', // Menambahkan label Resep Kopi
  ];

  List<bool> isPressed = [
    false,
    false,
    false,
    false,
    false, // Status untuk Toko Kopi
    false, // Status untuk Resep Kopi
  ];

  void _handleTap(int index) {
  setState(() {
    print('Menu yang dipilih: ${menuList[index]}');
    
    // Menambahkan logika untuk menavigasi ke halaman Toko Kopi dan Resep Kopi
    if (menuList[index] == 'Toko_Kopi') {
      print('Navigasi ke Toko Kopi');
      Get.toNamed(RouteName.tokoKopi);  // Navigasi ke Toko Kopi
    } else if (menuList[index] == 'Resep_Kopi') {
      print('Navigasi ke Resep Kopi');
      Get.toNamed(RouteName.resepKopi);  // Navigasi ke Resep Kopi
    } else {
      print('Navigasi ke kegiatan: ${RouteName.kegiatan}/${menuList[index]}');
      Get.toNamed('${RouteName.kegiatan}/${menuList[index]}');  // Untuk menu lainnya
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
        ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _handleTap(index); // Memanggil fungsi navigasi saat menu ditekan
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: isPressed[index] ? Colors.blue[900] : Color(0xffD4ECFF),
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imageList[index],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    labelMenu[index], // Menampilkan nama menu sesuai list
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
