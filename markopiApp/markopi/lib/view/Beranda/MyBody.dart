import 'package:flutter/material.dart';
import 'package:markopi/controllers/Artikel_Controller.dart';
import './MainMenu.dart';
import 'package:markopi/models/Artikel_Model.dart';
import 'package:get/get.dart';

class BerandaBody extends StatefulWidget {
  const BerandaBody({super.key});

  @override
  State<BerandaBody> createState() => _BerandaBodyState();
}

class _BerandaBodyState extends State<BerandaBody> {
  final ArtikelController artikelC = Get.put(ArtikelController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildWeatherCard(),
            SizedBox(height: 30),
            MainMenu(),
            SizedBox(height: 30),
            buildHorizontalListView(),
          ],
        ),
      ),
    );
  }

  // === KARTU CUACA DENGAN DESAIN GOOGLE CUACA ===
  Widget buildWeatherCard() {
    List<Map<String, dynamic>> forecast = [
      {"day": "Kam", "icon": Icons.beach_access, "temp": "24° 21°"},
      {"day": "Jum", "icon": Icons.flash_on, "temp": "26° 21°"},
      {"day": "Sab", "icon": Icons.beach_access, "temp": "26° 21°"},
      {"day": "Min", "icon": Icons.wb_sunny, "temp": "27° 21°"},
      {"day": "Sen", "icon": Icons.wb_cloudy, "temp": "28° 21°"},
      {"day": "Sel", "icon": Icons.wb_sunny, "temp": "29° 21°"},
      {"day": "Rab", "icon": Icons.cloud, "temp": "28° 21°"},
      {"day": "Kam", "icon": Icons.beach_access, "temp": "28° 21°"},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian atas
          Row(
            children: [
              Icon(Icons.flash_on, size: 64, color: Colors.orange),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('26°C', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Gerimis berpetir', style: TextStyle(fontSize: 16)),
                  Text('Presipitasi: 45%  Kelembapan: 79%  Angin: 6 km/h', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  Text('Jumat', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Divider(),

          // Forecast 7 hari
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.length,
              itemBuilder: (context, index) {
                var item = forecast[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item["day"], style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Icon(item["icon"], size: 32, color: Colors.blue[700]),
                      SizedBox(height: 8),
                      Text(item["temp"], style: TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // === ARTIKEL LIST ===
  Widget buildHorizontalListView() {
    return Obx(() {
      if (artikelC.artikel.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      List<Artikel> firstFourArtikels = artikelC.artikel.take(4).toList();
      return Container(
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
