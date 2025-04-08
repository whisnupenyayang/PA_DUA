import 'package:belajar_flutter/fasilitator/edit_artikel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:belajar_flutter/connection.dart';
import 'package:belajar_flutter/model/model_artikel.dart';

class ArtikelSayaPage extends StatefulWidget {
  @override
  _ArtikelSayaPageState createState() => _ArtikelSayaPageState();
}

class _ArtikelSayaPageState extends State<ArtikelSayaPage> {
  List<Artikel> _articles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final userId = AuthManager.getUserId();
      if (userId != null) {
        final response = await http.get(
          Uri.parse('${Connection.apiUrl}/artikelByUser/$userId'),
        );
        if (response.statusCode == 200) {
          final List<dynamic> responseData = jsonDecode(response.body);
          setState(() {
            _articles =
                responseData.map((json) => Artikel.fromJson(json)).toList();
          });
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('User not logged in');
      }
    } catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteArtikel(int index) async {
    try {
      final artikelId = _articles[index].id;
      final response = await http.delete(
        Uri.parse('${Connection.apiUrl}/artikel/$artikelId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _articles.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Artikel berhasil dihapus'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to delete article');
      }
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus artikel'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // void _updateArtikel(int index) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EditArtikelPage(
  //         artikel: _articles[index],
  //       ),
  //     ),
  //   );
  // }

  Future<void> _confirmDelete(int index) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin menghapus artikel ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteArtikel(index);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Artikel Saya',
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
          ? Center(child: CircularProgressIndicator())
          : _articles.isNotEmpty
              ? ListView.builder(
                  itemCount: _articles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                _articles[index].imageUrls.first,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _articles[index].judulArtikel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _articles[index].tanggal,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ElevatedButton(
                                //   onPressed: () {
                                //     _updateArtikel(index);
                                //   },
                                //   child: Text('Update'),
                                // ),
                                SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    _confirmDelete(index);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Tidak ada artikel',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
    );
  }
}
