import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:http_parser/http_parser.dart';
import 'package:belajar_flutter/connection.dart';

class AddForum extends StatefulWidget {
  @override
  _AddForumState createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  int? userId;
  late String apiUrl;

  final TextEditingController judulController = TextEditingController();
  String gambarPath = '';
  final TextEditingController deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiUrl = Connection.buildUrl('/forum');
    getUserId();
  }

  Future<void> getUserId() async {
    userId = await AuthManager.getUserId();
  }

  Future<void> submitPengajuan({
    required String judul,
    required String deskripsi,
    required int? userId,
    File? gambarFile,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.fields['title'] = judul;
      request.fields['deskripsi'] = deskripsi;
      request.fields['user_id'] = userId.toString();

      if (gambarFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'gambar',
          gambarFile.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Handle successful submission
        Navigator.pop(context, true); // Pop with true indicating success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Tambah Forum Berhasil'),
          backgroundColor: Colors.green,
        ));
        print('Sukses tambah forum');
      } else {
        // Handle failed submission
        print('Error during submission: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal melakukan forum. Silakan coba lagi.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      print("Error: $error");
      Navigator.pop(context);
    }
  }

  Future<void> _getFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          gambarPath = pickedFile.path;
        });
      }
    } catch (e) {
      var status = await Permission.photos.request();
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog(context);
      } else {
        print('Exception occurred!');
      }
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to gallery and photos'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedImage() {
    return gambarPath.isNotEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(
                  8.0), // Menambahkan padding di sekeliling gambar
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250, // Lebar gambar yang dipilih
                    height: 250, // Tinggi gambar yang dipilih
                    child: Image.file(
                      File(gambarPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors
                            .white, // Atur warna ikon sesuai dengan gambar
                      ),
                      onPressed: () {
                        setState(() {
                          gambarPath = ''; // Menghapus gambar yang dipilih
                        });
                      },
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox
            .shrink(); // Jika tidak ada gambar yang dipilih, kembalikan widget kosong
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forum',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Judul',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: judulController,
                    decoration: InputDecoration(
                      labelText: 'Judul',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Gambar',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                    child: ElevatedButton.icon(
                      onPressed: _getFromGallery,
                      icon: Icon(Icons.add,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                      label: Text(
                        'Pilih Gambar',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  _buildSelectedImage(),
                  SizedBox(height: 25),
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: deskripsiController,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    maxLines: 10,
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (userId != null) {
                          submitPengajuan(
                            judul: judulController.text,
                            deskripsi: deskripsiController.text,
                            gambarFile:
                                gambarPath.isNotEmpty ? File(gambarPath) : null,
                            userId: userId,
                          );
                        } else {
                          print('Error: User ID not available');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF142B44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: Text(
                        'Kirim',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
