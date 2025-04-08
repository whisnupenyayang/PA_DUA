import 'package:flutter/material.dart';
import 'package:belajar_flutter/newberanda/MyAppBar.dart';
import 'package:belajar_flutter/newberanda/MyBody.dart';
import 'package:belajar_flutter/artikel/artikel.dart';
import 'package:belajar_flutter/minuman/minuman.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/model/model_artikel.dart';
import 'package:belajar_flutter/model/model_minuman.dart';
import 'package:belajar_flutter/connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  int _selectedIndex = 0;
  bool isLoggedIn = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 0 && !isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 32),
          child: MyAppBar(),
        ),
      ),
      body: BerandaBody(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFFFFFFFF), // Background color
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 40,
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined,
                  color: Colors.black, size: 40),
              label: 'Komunitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.storefront_sharp,
                color: Colors.black,
                size: 40,
              ),
              label: 'Komunitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.article_outlined, // ← versi garis (outline)
                size: 40,
                color: Colors.black, // seluruh garis icon jadi hitam
              ),
              label: 'Notifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
                size: 40,
              ),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF297CBB),
          showSelectedLabels: _selectedIndex !=
              0, // Hide selected item label if it's not Beranda
          showUnselectedLabels: false, // Hide unselected items label
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
