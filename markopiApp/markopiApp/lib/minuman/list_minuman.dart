import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/connection.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:belajar_flutter/minuman/minuman.dart';
import 'package:belajar_flutter/model/model_minuman.dart';

class ListMinuman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Minuman',
            style: TextStyle(
              color: Colors.white,
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
        body: FutureBuilder<List<Minuman>>(
          future: fetchMinuman(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  // Ganti TabBar menjadi judul teks "Resep Kopi" di tengah dengan ukuran 20
                  Center(
                    child: Text(
                      'Resep Kopi',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 10), // Beri sedikit spasi antara judul dan konten
                  Expanded(
                    child: buildListView(snapshot.data),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildListView(List<Minuman>? data) {
    if (data == null || data.isEmpty) {
      return Center(
        child: Text("Tidak ada data"),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Minuman minuman = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MinumanPage(minumanData: minuman),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Center children horizontally in the Row
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the text vertically in the Column
                      children: <Widget>[
                        Text(
                          minuman.namaMinuman,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        minuman.imageUrls.first,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 120,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<List<Minuman>> fetchMinuman() async {
  final response = await http.get(Uri.parse(Connection.buildUrl('/minuman')));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Minuman.fromJson(json)).toList();
  } else {
    throw Exception('Gagal memuat data');
  }
}
