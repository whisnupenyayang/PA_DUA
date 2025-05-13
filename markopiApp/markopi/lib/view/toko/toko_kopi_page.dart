import 'package:flutter/material.dart';
import 'package:markopi/service/toko_service.dart';
import 'package:markopi/models/toko.dart';
import 'package:url_launcher/url_launcher.dart'; // Package untuk membuka URL

class TokoKopiPage extends StatelessWidget {
  const TokoKopiPage({super.key});

  // Fungsi untuk membuka lokasi toko di Google Maps
  Future<void> _launchMapsUrl(String locationUrl) async {
    if (await canLaunch(locationUrl)) {
      await launch(locationUrl);
    } else {
      throw 'Could not launch $locationUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Toko Kopi'),
      ),
      body: FutureBuilder<List<Toko>?>(
        future: TokoService.getAllTokos(), // Memanggil service untuk mendapatkan data toko
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
                final toko = tokos[index];

                return GestureDetector(
                  onTap: () {
                    _launchMapsUrl(toko.lokasi); // Membuka lokasi di Google Maps
                  },
                  child: Card(
                    child: ListTile(
                      leading: toko.fotoToko.isNotEmpty
                          ? Image.network(
                              toko.fotoToko,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.store), // default icon jika tidak ada foto
                      title: Text(toko.namaToko),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            toko.lokasi,
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          // Menampilkan jam operasional toko
                          Text('Jam Operasional: ${toko.jamOperasional}'),
                        ],
                      ),
                      trailing: const Icon(Icons.location_on),
                    ),
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
