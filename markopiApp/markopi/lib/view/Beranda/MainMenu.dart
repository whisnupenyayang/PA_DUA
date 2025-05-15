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
    'assets/images/budidaya_baru.jpg',
    'assets/images/panen_baru.jpg',
    'assets/images/pascapanen_baru.jpg',
    'assets/images/toko_kopi.jpg',
    'assets/images/resepkopi.jpg',
  ];

  final List<String> menuList = [
    'Budidaya',
    'Panen',
    'Pasca_Panen',
    'Toko_Kopi',
    'Resep_Kopi',
  ];

  final List<String> labelMenu = [
    'Budidaya',
    'Panen',
    'PascaPanen',
    'Toko Kopi',
    'Resep Kopi',
  ];

  List<bool> isPressed = List.generate(5, (_) => false);

  void _handleTap(int index) {
    setState(() {
      print('Menu yang dipilih: ${menuList[index]}');

      if (menuList[index] == 'Toko_Kopi') {
        print('Navigasi ke Toko Kopi');
        Get.toNamed(RouteName.tokoKopi);
      } else if (menuList[index] == 'Resep_Kopi') {
        print('Navigasi ke Resep Kopi');
        Get.toNamed(RouteName.resepKopi);
      } else {
        print('Navigasi ke kegiatan: ${RouteName.kegiatan}/${menuList[index]}');
        Get.toNamed('${RouteName.kegiatan}/${menuList[index]}');
      }
    });
  }

  Widget buildMenuItem(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 100,
        height: 110,
        decoration: BoxDecoration(
          color: isPressed[index] ? Colors.blue[900] : Colors.transparent,
          border: Border.all(
            color: Colors.black.withOpacity(0.5),
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageList[index],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              labelMenu[index],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          // Baris 1 - 3 menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildMenuItem(0),
              buildMenuItem(1),
              buildMenuItem(2),
            ],
          ),
          const SizedBox(height: 20),
          // Baris 2 - 2 menu, rata tengah dengan spasi di antaranya
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMenuItem(3),
              const SizedBox(width: 30),
              buildMenuItem(4),
            ],
          ),
        ],
      ),
    );
  }
}
