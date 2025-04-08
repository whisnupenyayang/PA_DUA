import 'package:flutter/material.dart';
import '../autentikasi/auth_manager_page.dart';

class InformationPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Pemilihan Lahan',
      'imagePath': 'assets/images/syarat_tumbuh.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Kesesuaian Lahan',
      'imagePath': 'assets/images/pola_tanam.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Persiapan Lahan',
      'imagePath': 'assets/images/persiapan_lahan.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Penanaman Penaung',
      'imagePath': 'assets/images/penanaman_penaung.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Bahan Tanam Unggul',
      'imagePath': 'assets/images/unggul.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Pembibitan',
      'imagePath': 'assets/images/pembibitan.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Penanaman',
      'imagePath': 'assets/images/penanaman.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Pemupukan',
      'imagePath': 'assets/images/pemupukan.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Pemangkasan',
      'imagePath': 'assets/images/pemangkasan.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Pengelolaan Penaung',
      'imagePath': 'assets/images/pengelolaan_penaung.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Pengendalian Hama',
      'imagePath': 'assets/images/hama.png', // Ganti dengan path gambar Anda
    },
  ];

  void _navigateBasedOnRole(BuildContext context) async {
    String? role = await AuthManager.getUserRole();
    print('Role: $role'); // Debug print
    if (role == 'petani') {
      Navigator.pushReplacementNamed(context, '/beranda_petani');
    } else if (role == 'fasilitator') {
      Navigator.pushReplacementNamed(context, '/beranda_fasilitator');
    } else {
      Navigator.pushReplacementNamed(context, '/beranda');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Budidaya',
          style: TextStyle(
            color: Colors.white, // Warna teks di AppBar
          ),
        ),
        backgroundColor: Color(0xFF142B44),
        leading: IconButton(
          onPressed: () => _navigateBasedOnRole(context),
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      categories.length,
                      (index) {
                        var category = categories[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigasi ke halaman yang sesuai berdasarkan kategori
                                Navigator.pushNamed(
                                  context,
                                  '/${category['name'].toLowerCase().replaceAll(' ', '_')}',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0), // Mengatur padding di sebelah kiri
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipOval(
                                        child: Image.asset(
                                          category['imagePath'],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    category['name'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(Icons.chevron_right),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(), // Menambahkan divider sebagai pembatas setiap item
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
