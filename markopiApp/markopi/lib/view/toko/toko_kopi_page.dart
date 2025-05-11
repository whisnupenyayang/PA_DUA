import 'package:flutter/material.dart';
import 'package:markopi/service/toko_service.dart';
import 'package:markopi/models/toko.dart';

class TokoKopiPage extends StatelessWidget {
  const TokoKopiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Toko Kopi'),
      ),
      body: FutureBuilder<List<Toko>?>(
        future: TokoService
            .getAllTokos(), // Memanggil service untuk mendapatkan data toko
        builder: (context, snapshot) {
          // Jika data sedang dimuat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Jika ada error dalam pemanggilan data
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Jika data kosong atau tidak ada
          else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data toko'));
          }
          // Jika data ada
          else {
            List<Toko> tokos = snapshot.data!;

            return ListView.builder(
              itemCount: tokos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: tokos[index].fotoToko.isNotEmpty
                        ? Image.network(
                            tokos[index].fotoToko,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.store), // default icon jika tidak ada foto
                    title: Text(tokos[index].namaToko),
                    subtitle: Text(tokos[index].lokasi),
                    trailing: const Icon(Icons.location_on),
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
