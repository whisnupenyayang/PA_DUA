import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/route_name.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  bool isLoggedIn = false;

  final List<String> navList = [
    RouteName.beranda,
    RouteName.forum,
    RouteName.forum,
    RouteName.forum,
    RouteName.forum,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index != 0 && !isLoggedIn) {
        Get.offAllNamed(RouteName.forum);
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
      showSelectedLabels: true, // label selalu tampil saat item dipilih
      showUnselectedLabels: false, // label tampil untuk item yang tidak dipilih
      onTap: _onItemTapped,
    );
  }
}
