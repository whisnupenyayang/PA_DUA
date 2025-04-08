import 'package:flutter/material.dart';

class notifikasi extends StatefulWidget {
  @override
  _notifikasiState createState() => _notifikasiState();
}

class _notifikasiState extends State<notifikasi> {
  int _selectedIndex = 2;

  // Metode untuk menangani penekanan item pada BottomNav
  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          // Navigasi ke halaman beranda
          Navigator.pushReplacementNamed(context, '/beranda_petani');
          break;
        case 1:
          // Navigasi ke halaman notifikasi
          Navigator.pushReplacementNamed(context, '/petani_list_forum');
          break;
        case 3:
          // Navigasi ke halaman profil
          Navigator.pushReplacementNamed(context, '/profil_petani');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NOTIFIKASI",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Khula',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF142B44),
      ),
      body: Center(
        child: Text(
          'Ini Halaman Notifikasi Petani!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF142B44), // Background color
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Komunitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profil',
            ),
          ],
          selectedItemColor: Colors.amber[800],
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
