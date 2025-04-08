import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:belajar_flutter/connection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/model/model_artikel.dart';
import 'package:belajar_flutter/artikel/artikel.dart';
import 'package:belajar_flutter/newberanda/MainMenu.dart';

class BerandaBody extends StatefulWidget {
  const BerandaBody({super.key});

  @override
  State<BerandaBody> createState() => _BerandaBodyState();
}

class _BerandaBodyState extends State<BerandaBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ----------------- SECTION HEADER -----------------
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
            // ----------------- SECTION SCROLL HORIZONTAL -----------------
            buildHorizontalListView(),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalListView() {
    return FutureBuilder<List<Artikel>>(
      future: fetchArtikel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Ambil 4 artikel pertama
          List<Artikel> firstFourArtikels = snapshot.data!.take(4).toList();

          return Container(
            height: 257,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(firstFourArtikels.length, (index) {
                  Artikel artikel = firstFourArtikels[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticlePage(articleData: artikel),
                        ),
                      );
                    },
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),

                              // image: DecorationImage(
                              //   image: NetworkImage(artikel.imageUrls.first),
                              //   fit: BoxFit.cover,
                              // ),
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
        }
      },
    );
  }

  Future<List<Artikel>> fetchArtikel() async {
    final url = Connection.buildUrl('artikel');
    print('Requesting: $url');

    final response = await http.get(Uri.parse(url));

    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> rawData = responseData["data"];
      return rawData.map((json) => Artikel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data ah');
    }
  }
}
