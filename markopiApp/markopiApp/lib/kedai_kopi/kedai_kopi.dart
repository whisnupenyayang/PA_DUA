// syarat_tumbuh_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_kedai_kopi.dart';

class KedaiKopiPage extends StatelessWidget {
  final String apiUrl = "http://127.0.0.1:8000/api/kedai";

  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kedai Kopi'),
        backgroundColor: Color(0xFF65451F),
      ),
      // Tambahkan background image
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Ganti dengan path gambar yang diinginkan
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      snapshot.data.length,
                      (index) {
                        var data = snapshot.data[index];
                        var nama_kedai = data['nama_kedai'];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailKedaiKopiPage(data: data),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFF8E745C), // Warna tombol
                                alignment: Alignment.centerLeft, // Rata kiri
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  nama_kedai,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white, // Warna teks putih
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
