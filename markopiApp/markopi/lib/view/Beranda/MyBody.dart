import 'package:flutter/material.dart';
import 'package:markopi/controllers/Artikel_Controller.dart';
import 'package:markopi/service/token_storage.dart';
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
  bool isLoading = true;
  String? token;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            MainMenu(),
            SizedBox(height: 30),
            buildHorizontalListView(),
          ],
        ),
      ),
    );
  }

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
