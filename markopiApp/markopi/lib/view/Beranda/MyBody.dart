import 'package:flutter/material.dart';
import 'package:markopi/controllers/Artikel_Controller.dart';
import 'package:markopi/controllers/Pengepul_Controller.dart'; // Import pengepul controller
import 'package:markopi/service/token_storage.dart';
import './MainMenu.dart';
import 'package:markopi/models/Artikel_Model.dart';
import 'package:markopi/models/Pengepul_Model.dart'; // Import pengepul model
import 'package:get/get.dart';
import 'package:markopi/view/iklan/iklan_banner.dart';

class BerandaBody extends StatefulWidget {
  const BerandaBody({super.key});

  @override
  State<BerandaBody> createState() => _BerandaBodyState();
}

class _BerandaBodyState extends State<BerandaBody> {
  final ArtikelController artikelC = Get.put(ArtikelController());
  final PengepulController pengepulC = Get.put(PengepulController()); // Instance pengepul controller
  bool isLoading = true;
  String? token;

  @override
  void initState() {
    super.initState();
    artikelC.fetchArtikel();
    pengepulC.fetchPengepul(); // Fetch pengepul data
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            MainMenu(),
            SizedBox(height: 30),
            const Text(
              'Harga Rata-rata Kopi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildHargaRataRata(), // Display average price
            SizedBox(height: 30),
            const Text(
              'Artikel Terbaru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildHorizontalListView(),
            SizedBox(height: 30),
            IklanBanner(),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan harga rata-rata pengepul
  Widget buildHargaRataRata() {
    return Obx(() {
      if (pengepulC.pengepul.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      // Menghitung harga rata-rata
      double totalHarga = 0;
      pengepulC.pengepul.forEach((item) {
        totalHarga += item.harga ?? 0; // Pastikan harga tidak null
      });
      double hargaRataRata = totalHarga / pengepulC.pengepul.length;

      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Harga Rata-rata: Rp ${hargaRataRata.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    });
  }

  Widget buildHorizontalListView() {
    return Obx(() {
      if (artikelC.artikel.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      List<Artikel> firstFourArtikels = artikelC.artikel.take(4).toList();
      return SizedBox(
        height: 257,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(firstFourArtikels.length, (index) {
              Artikel artikel = firstFourArtikels[index];
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 257,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 148,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          image: artikel.imageUrls.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(artikel.imageUrls.first),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 46,
                        width: 268,
                        margin: EdgeInsets.all(13),
                        child: Text(
                          artikel.judulArtikel,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
