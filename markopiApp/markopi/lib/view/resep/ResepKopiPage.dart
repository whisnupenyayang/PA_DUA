import 'package:flutter/material.dart';
import 'package:markopi/models/resep.dart';

class ResepDetailPage extends StatelessWidget {
  final Resep resep;

  const ResepDetailPage({super.key, required this.resep});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resep.namaResep),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar resep
            resep.gambarResep.isNotEmpty
                ? Image.network(
                    resep.gambarResep,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  )
                : const Icon(Icons.image_not_supported, size: 150),
            const SizedBox(height: 16),
            // Menampilkan nama resep
            Text(
              resep.namaResep,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Menampilkan deskripsi resep
            Text(
              resep.deskripsiResep,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
