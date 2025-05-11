import 'package:flutter/material.dart';
import 'package:markopi/service/resep_service.dart';
import 'package:markopi/models/resep.dart';

class ResepKopiPage extends StatelessWidget {
  const ResepKopiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Kopi'),
      ),
      body: FutureBuilder<List<Resep>>(
        future: ResepService.getAllReseps(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Tidak ada resep kopi ditemukan.'),
            );
          } else {
            final reseps = snapshot.data!;
            return ListView.builder(
              itemCount: reseps.length,
              itemBuilder: (context, index) {
                final resep = reseps[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: resep.gambarResep.isNotEmpty
                        ? Image.network(
                            // Pastikan URL sesuai dengan backend
                            resep.gambarResep,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 40);
                            },
                          )
                        : Icon(Icons.image_not_supported, size: 40), // fallback icon
                    title: Text(resep.namaResep),
                    subtitle: Text(
                      resep.deskripsiResep.length > 100
                          ? resep.deskripsiResep.substring(0, 100) + '...'
                          : resep.deskripsiResep,
                    ),
                    onTap: () {
                      // Bisa diarahkan ke halaman detail
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
