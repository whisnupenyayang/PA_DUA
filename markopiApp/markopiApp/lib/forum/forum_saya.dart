import 'package:belajar_flutter/forum/edit_forum.dart';
import 'package:belajar_flutter/model/model_forum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:belajar_flutter/connection.dart';

class ForumSayaPage extends StatefulWidget {
  @override
  _ForumSayaPageState createState() => _ForumSayaPageState();
}

class _ForumSayaPageState extends State<ForumSayaPage> {
  List<Forum> _forum = [];
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
          Uri.parse(Connection.buildUrl('/user/forum/$userId')),
        );
        if (response.statusCode == 200) {
          final dynamic responseData = jsonDecode(response.body);
          setState(() {
            // Periksa apakah responseData adalah list atau objek tunggal
            if (responseData['status'] == 'success') {
              final List<dynamic> forumData = responseData['data'];
              _forum = forumData.map((json) => Forum.fromJson(json)).toList();
            } else {
              throw Exception('Failed to load data');
            }
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

  Future<void> _deleteForum(int index) async {
    try {
      final forumId = _forum[index].id;
      final response = await http.delete(
        Uri.parse('${Connection.apiUrl}/forum/$forumId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _forum.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Forum berhasil dihapus'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Gagal menghapus forum');
      }
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus forum'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // void _updateForum(int index) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EditForumPage(
  //         forum: _forum[index],
  //       ),
  //     ),
  //   );
  // }

  Future<void> _confirmDelete(int index) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin menghapus forum ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteForum(index);
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
          'Forum Saya',
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
          : _forum.isNotEmpty
              ? ListView.builder(
                  itemCount: _forum.length,
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
                                _forum[index].imageUrls.first,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _forum[index].tanggal,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _forum[index].judulForum,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _forum[index].deskripsiForum,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ElevatedButton(
                                //   onPressed: () {
                                //     _updateForum(index);
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
                    'Tidak ada Forum',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
    );
  }
}
