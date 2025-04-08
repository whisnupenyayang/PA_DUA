import 'package:flutter/material.dart';

class Komunitas extends StatefulWidget {
  @override
  _KomunitasState createState() => _KomunitasState();
}

class _KomunitasState extends State<Komunitas> {
  int _selectedIndex = 1; // Indeks terkait dengan halaman komunitas

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
        case 2:
          // Navigasi ke halaman notifikasi
          Navigator.pushReplacementNamed(context, '/notifikasi');
          break;
        case 3:
          // Navigasi ke halaman profil
          Navigator.pushReplacementNamed(context, '/profil');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KOMUNITAS",
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
          'Ini Halaman Komunitas!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Addforum');
        },
        tooltip: 'Tambah Forum',
        backgroundColor: Colors.amber[800],
        child: Icon(Icons.add),
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
