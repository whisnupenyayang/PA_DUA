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
  ];

  final List<String> menuList = [
    RouteName.budidaya,
    RouteName.panen,
    RouteName.pascaPanen,
    RouteName.laporan,
  ];

  final List<String> labelMenu = [
    'Budidaya',
    'Panen',
    'Pasca Panen',
    'Laporan',
  ];

  void _handleTap(int index) {
    Get.toNamed(menuList[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
        ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _handleTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffD4ECFF),
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
                    style: const TextStyle(fontSize: 20),
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
