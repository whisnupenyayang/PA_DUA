import 'package:flutter/material.dart';

class TambahPertanyaan extends StatelessWidget {
  const TambahPertanyaan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pertanyaan'),
      ),
      body: const Center(
        child: Text('Halaman Tambah Pertanyaan'),
      ),
    );
  }
}
