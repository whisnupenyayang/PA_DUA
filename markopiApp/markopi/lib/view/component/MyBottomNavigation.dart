import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/route_name.dart';
import 'package:markopi/service/token_storage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  String? token;
  @override
  void initState() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    token = await TokenStorage.getToken();
    print('Token yang tersimpan: $token');
  }

  int _selectedIndex = 0;
  bool isLoggedIn = false;

  final List<String> navList = [
    RouteName.beranda,
    RouteName.forum,
    RouteName.pengepul,
    RouteName.forum,
    RouteName.profile,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (token == null) {
        Get.toNamed(
          RouteName.login,
        );
        return;
      }

      Get.offAllNamed(navList[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, color: Colors.black, size: 40),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined, color: Colors.black, size: 40),
          label: 'Forum',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront_sharp, color: Colors.black, size: 40),
          label: 'Komunitas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined, color: Colors.black, size: 40),
          label: 'Notifikasi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined,
              color: Colors.black, size: 40),
          label: 'Profil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF297CBB),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
    );
  }
}
