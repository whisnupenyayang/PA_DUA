import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Artikel_Controller.dart';


class ListArtikel extends StatefulWidget {
  @override
  _ListArtikelState createState() => _ListArtikelState();
}

class _ListArtikelState extends State<ListArtikel> {
  // final List<Map<String, String>> artikelList = [
  //   {
  //     "title": "Budidaya Tanaman Kopi dengan Cara Stek",
  //     "desc":
  //         "Budidaya tanaman kopi menggunakan teknik vegetative stek batang memiliki banyak keuntungan....",
  //     "image":
  //         "https://upload.wikimedia.org/wikipedia/commons/e/e7/Coffee_cherries_2.jpg",
  //   },
  //   {
  //     "title": "Kenali Hama Penyakit Tanaman Kopi dan Pengendaliannya",
  //     "desc":
  //         "Serangan hama dan penyakit pada tanaman kopi dapat menurunkan produktivitas...",
  //     "image":
  //         "https://upload.wikimedia.org/wikipedia/commons/6/6d/Leaf_rust_on_coffee.jpg",
  //   },
  // ];
  var artikelC  = Get.put(ArtikelController());

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
            child: Obx((){
              return ListView.builder(
              itemCount: artikelC.artikel.length,
              itemBuilder: (context, index) {
                final data = artikelC.artikel[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                          // child: Image.network(
                          //   d,
                          //   height: 180,
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.judulArtikel,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                data.isiArtikel!,
                                style: TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Lihat Selengkapnya",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
            })
          )
        ],
      ),
    );
  }
}
