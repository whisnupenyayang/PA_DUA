import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:belajar_flutter/connection.dart';
import 'package:belajar_flutter/artikel/artikel.dart';
import 'package:belajar_flutter/model/model_artikel.dart';

class ListArtikelFasilitator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Artikel',
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          backgroundColor: Color(0xFF142B44),
          leading: IconButton(
            onPressed: () {
              // Kembali ke route sebelumnya
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
        body: FutureBuilder<List<Artikel>>(
          future: fetchArtikel(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Semua'),
                      Tab(text: 'Pupuk'),
                      Tab(text: 'Pesticide'),
                      Tab(text: 'Panen'),
                      Tab(text: 'Penanaman'),
                      // Add more if needed
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildListView(snapshot.data),
                        buildListView(snapshot.data),
                        buildListView(snapshot.data),
                        buildListView(snapshot.data),
                        buildListView(snapshot.data),
                        // Add more if needed
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_artikel');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF142B44),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget buildListView(List<Artikel>? data) {
    if (data == null || data.isEmpty) {
      return Center(
        child: Text("Tidak ada data"),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Artikel artikel = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlePage(
                    articleData:
                        artikel), // Navigasi ke halaman detail dengan membawa objek Artikel yang dipilih
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artikel.tanggal,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
                Image.network(
                  artikel.imageUrls.first,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    artikel.judulArtikel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    artikel.isiArtikel,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 10),
                // ButtonBar(
                //   alignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Row(
                //       children: <Widget>[
                //         IconButton(
                //           icon: Icon(Icons.thumb_up),
                //           onPressed: () {
                //             // Handle like
                //           },
                //         ),
                //         Text('Suka'),
                //       ],
                //     ),
                //     Row(
                //       children: <Widget>[
                //         IconButton(
                //           icon: Icon(Icons.thumb_down),
                //           onPressed: () {
                //             // Handle dislike
                //           },
                //         ),
                //         Text('Tidak Suka'),
                //       ],
                //     ),
                //     Row(
                //       children: <Widget>[
                //         IconButton(
                //           icon: Icon(Icons.comment),
                //           onPressed: () {
                //             // Handle comments
                //           },
                //         ),
                //         Text('Komentar'),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<List<Artikel>> fetchArtikel() async {
  final response = await http.get(Uri.parse(Connection.buildUrl('/artikel')));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Artikel.fromJson(json)).toList();
  } else {
    throw Exception('Gagal memuat data');
  }
}
