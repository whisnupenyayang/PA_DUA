import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:markopi/controllers/Artikel_Controller.dart';
import './MainMenu.dart';
import 'package:markopi/models/Artikel_Model.dart';
import 'package:http/http.dart' as http;
import 'package:markopi/providers/Connection.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 13,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanaman Kopi Anda',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'Hasil Terbaik &',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'Hasil terpercaya',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'di Markopi',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 143,
                    height: 143,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
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
