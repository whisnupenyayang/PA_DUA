import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/connection.dart';
import 'package:belajar_flutter/artikel/artikel.dart';
import 'package:belajar_flutter/model/model_artikel.dart';

class ListArtikel extends StatefulWidget {
  @override
  _ListArtikelState createState() => _ListArtikelState();
}

class _ListArtikelState extends State<ListArtikel> {
  List<Artikel> _listArtikel = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchArtikel(); // Ambil data saat widget pertama kali dibuat
  }

  Future<void> _fetchArtikel() async {
    try {
      final response =
          await http.get(Uri.parse(Connection.buildUrl('/artikel')));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey("data") && responseData["data"] is List) {
          List<dynamic> rawData = responseData["data"];
          setState(() {
            _listArtikel = rawData
                .map((item) => Artikel.fromJson(item as Map<String, dynamic>))
                .toList();
            _isLoading = false;
          });
        } else {
          throw Exception("Format data API tidak sesuai");
        }
      } else {
        throw Exception("Gagal memuat data");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Artikel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF142B44),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
        body: _isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Tampilkan loading indicator
            : _errorMessage.isNotEmpty
                ? Center(
                    child:
                        Text(_errorMessage)) // Jika ada error, tampilkan pesan
                : Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'Semua'),
                          Tab(text: 'Pupuk'),
                          Tab(text: 'Pesticide'),
                          Tab(text: 'Panen'),
                          Tab(text: 'Penanaman'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            buildListView(),
                            buildListView(),
                            buildListView(),
                            buildListView(),
                            buildListView(),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget buildListView() {
    if (_listArtikel.isEmpty) {
      return Center(
        child: Text("Tidak ada data"),
      );
    }

    return ListView.builder(
      itemCount: _listArtikel.length,
      itemBuilder: (BuildContext context, int index) {
        Artikel artikel = _listArtikel[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlePage(articleData: artikel),
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
                SizedBox(height: 15.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
