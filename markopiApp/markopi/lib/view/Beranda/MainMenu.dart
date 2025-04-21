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
    'panen',
    'pasca_panen',
    'budidaya', 
  ];

  final List<String> labelMenu = [
    'Budidaya',
    'Panen',
    'Pasca Panen',
    'Laporan'
  ];

  List<bool> isPressed = [
    false,
    false,
    false,
    false,
  ];

  void _handleTap(int index) {
    setState(() {
      isPressed[index] = true;
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
              _handleTap(index); // biar efek warna ditekan jalan
              Get.toNamed(menuList[index]);
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
                    labelMenu[index], // tampilkan nama menu sesuai list
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
