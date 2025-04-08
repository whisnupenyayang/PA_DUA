// proses_budidaya_page.dart

import 'package:flutter/material.dart';

class SuccessLoginPage extends StatelessWidget {
  final int userId;

  SuccessLoginPage({required this.userId});

  final List<String> categories = [
    'Budidaya',
    'Panen',
    'Pasca Panen',
    'Penjualan',
    'Kedai Kopi',
    'Komunitas Petani',
    'Pengajuan',
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proses Budidaya'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              categories.length,
              (index) {
                var category = categories[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke InformationPage saat kategori 'Budidaya' dipilih
                        if (category == 'Budidaya') {
                          Navigator.pushReplacementNamed(context, '/budidaya');
                        } else if (category == 'Panen') {
                          Navigator.pushReplacementNamed(context, '/panen');
                        } else if (category == 'Pengajuan') {
                          Navigator.pushReplacementNamed(
                              context, '/addpengajuan');
                        }
                      },
                      child: Text(category),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
