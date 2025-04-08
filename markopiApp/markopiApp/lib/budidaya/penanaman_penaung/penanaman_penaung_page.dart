// pembibitan_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_penanaman_penaung_page.dart';
import 'package:belajar_flutter/connection.dart'; // Import file connection.dart

class PenanamanPenaungPage extends StatefulWidget {
  @override
  _PenanamanPenaungPageState createState() => _PenanamanPenaungPageState();
}

class _PenanamanPenaungPageState extends State<PenanamanPenaungPage> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchDataUsers();
  }

  Future<List<dynamic>> _fetchDataUsers() async {
    var result = await http.get(Uri.parse(Connection.buildUrl(
        '/budidaya/penanaman_penaung'))); // Menggunakan Connection.buildUrl()
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Budidaya',
          style: TextStyle(
            color: Colors.white, // Warna teks di AppBar
          ),
        ),
        backgroundColor: Color(0xFF142B44),
        leading: IconButton(
          onPressed: () {
            // Navigasi ke halaman sebelumnya
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Penanaman Penaung',
                style: TextStyle(
                  fontSize: 24, // Ukuran font 24
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _futureData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data[index];
                        var tahapan = data['tahapan'];
                        var imageUrls = List<String>.from(data['images'].map(
                            (image) => image['url'])); // List of image URLs

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPenanamanPenaungPage(data: data),
                                  ),
                                );
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  imageUrls.isNotEmpty
                                      ? imageUrls[0]
                                      : '', // Menggunakan URL gambar pertama jika tersedia
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                tahapan,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
                            Divider(), // Menambahkan divider sebagai pembatas setiap item
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
