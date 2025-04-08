import 'package:flutter/material.dart';
import '../autentikasi/auth_manager_page.dart';

class PascaPanenPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Fermentasi Kering',
      'imagePath': 'assets/images/kering.png', // Ganti dengan path gambar Anda
    },
    {
      'name': 'Fermentasi Mekanis',
      'imagePath': 'assets/images/mekanis.png', // Ganti dengan path gambar Anda
    },
  ];

  void _navigateBasedOnRole(BuildContext context) async {
    String? role = await AuthManager.getUserRole();
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
          'Markopi',
          style: TextStyle(
            color: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 15.0,
                  top: 10.00,
                ),
                child: Text(
                  'Pasca Panen',
                  style: TextStyle(
                    fontSize: 24, // Ukuran font 24
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
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
                                padding: const EdgeInsets.fromLTRB(
                                    30.0,
                                    0.0,
                                    0.0,
                                    0.0), // Mengatur padding di sebelah kiri
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    category['name'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
