import 'package:flutter/material.dart';
import './MyAppBar.dart';
import './MyBody.dart';
import '../component/MyBottomNavigation.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
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
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFFFFFFFF)),
        child: const MyBottomNavigationBar(), // 👈 sudah modular
      ),
    );
  }
}
