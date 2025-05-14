import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Artikel_Controller.dart';
import 'package:markopi/models/Artikel_Model.dart';
import 'package:markopi/view/artikel/detail_artikel.dart';

class ListArtikel extends StatefulWidget {
  @override
  _ListArtikelState createState() => _ListArtikelState();
}

class _ListArtikelState extends State<ListArtikel> {
  final ArtikelController artikelC = Get.put(ArtikelController());

  @override
  void initState() {
    super.initState();
    artikelC.fetchArtikel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informasi Kopi"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (artikelC.artikel.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: artikelC.artikel.length,
                itemBuilder: (context, index) {
                  final Artikel artikel = artikelC.artikel[index];

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              artikel.judulArtikel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              artikel.isiArtikel ?? '',
                              style: TextStyle(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => DetailArtikel(artikel: artikel));
                              },
                              child: Text(
                                "Lihat Selengkapnya",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
