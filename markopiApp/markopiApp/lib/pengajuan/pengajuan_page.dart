import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:http_parser/http_parser.dart';
import '../connection.dart'; // Import file connection.dart

class PengajuanPage extends StatefulWidget {
  @override
  _PengajuanPageState createState() => _PengajuanPageState();
}

class _PengajuanPageState extends State<PengajuanPage> {
  late String apiUrl;

  String fotoKTPPath = '';
  String fotoSelfiePath = '';
  String fotoSertifikatPath = '';
  final TextEditingController deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiUrl = Connection.buildUrl(
        '/pengajuantambah'); // Menggunakan buildUrl dari Connection
  }

  Future<void> submitPengajuan({
    required String fotoKTP,
    required String fotoSelfie,
    required String deskripsiPengalaman,
    required String fotoSertifikat,
    required int? userId,
  }) async {
    try {
      // Validasi input
      if (fotoKTP.isEmpty ||
          fotoSelfie.isEmpty ||
          deskripsiPengalaman.isEmpty ||
          fotoSertifikat.isEmpty ||
          userId == null) {
        print('Error: Ada field yang kosong');
        // Beritahu pengguna tentang field yang kosong
        if (fotoKTP.isEmpty) {
          print('Field fotoKTP kosong');
        }
        if (fotoSelfie.isEmpty) {
          print('Field fotoSelfie kosong');
        }
        if (deskripsiPengalaman.isEmpty) {
          print('Field deskripsiPengalaman kosong');
        }
        if (fotoSertifikat.isEmpty) {
          print('Field fotoSertifikat kosong');
        }
        if (userId == null) {
          print('Field userId kosong');
        }
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.fields['deskripsi_pengalaman'] = deskripsiPengalaman;
      request.fields['user_id'] = userId.toString();

      request.files.add(await http.MultipartFile.fromPath(
        'foto_ktp',
        fotoKTP,
        contentType: MediaType('image', 'jpeg'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'foto_selfie',
        fotoSelfie,
        contentType: MediaType('image', 'jpeg'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'foto_sertifikat',
        fotoSertifikat,
        contentType: MediaType('image', 'jpeg'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Handle successful submission

        Navigator.pop(context, true); // Pop with true indicating success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pengajuan berhasil'),
          backgroundColor: Colors.green,
        ));
        print('Pengajuan berhasil');
      } else {
        // Handle failed submission
        print('Error during submission: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal melakukan pengajuan. Silakan coba lagi.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  String? _validateDeskripsiPengalaman(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length < 10 || value.length > 300) {
        return 'Deskripsi Pengalaman harus memiliki panjang 10-300 karakter';
      }
    }
    return null;
  }

  Future<void> _pickImage(String field, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          if (field == 'foto_ktp') {
            fotoKTPPath = pickedFile.path;
          } else if (field == 'foto_selfie') {
            fotoSelfiePath = pickedFile.path;
          } else if (field == 'foto_sertifikat') {
            fotoSertifikatPath = pickedFile.path;
          }
        });
      }
    } catch (e) {
      var status = await Permission.camera.request();
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

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF142B44),
      minimumSize:
          Size(double.infinity, 50), // Button width set to screen width
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Pengajuan',
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
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Foto KTP (Kartu Tanda Penduduk)',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _pickImage('foto_ktp', ImageSource.gallery),
                style: buttonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_library, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Pilih Foto KTP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildSelectedImage('foto_ktp'),
              SizedBox(height: 16),
              Text(
                'Foto Selfie',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _pickImage('foto_selfie', ImageSource.camera),
                style: buttonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Ambil Foto Selfie',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildSelectedImage('foto_selfie'),
              SizedBox(height: 16),
              Text(
                'Foto Sertifikat',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    _pickImage('foto_sertifikat', ImageSource.gallery),
                style: buttonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_library, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Pilih Foto Sertifikat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildSelectedImage('foto_sertifikat'),
              SizedBox(height: 16),
              Text(
                'Deskripsi Pengalaman',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Pengalaman',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validateDeskripsiPengalaman(value),
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (AuthManager.isLoggedIn()) {
                    final userId = await AuthManager.getUserId();
                    if (userId != null) {
                      submitPengajuan(
                        fotoKTP: fotoKTPPath,
                        fotoSelfie: fotoSelfiePath,
                        deskripsiPengalaman: deskripsiController.text,
                        fotoSertifikat: fotoSertifikatPath,
                        userId: userId,
                      );
                    } else {
                      print('Error: User ID not available');
                    }
                  } else {
                    // Jika user belum login, arahkan ke halaman login
                    Navigator.pushNamed(context, '/login');
                  }
                },
                style: buttonStyle,
                child: Text(
                  'Submit Pengajuan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImage(String field) {
    String imagePath = '';
    if (field == 'foto_ktp') {
      imagePath = fotoKTPPath;
    } else if (field == 'foto_selfie') {
      imagePath = fotoSelfiePath;
    } else if (field == 'foto_sertifikat') {
      imagePath = fotoSertifikatPath;
    }

    return imagePath.isNotEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (field == 'foto_ktp') {
                            fotoKTPPath = '';
                          } else if (field == 'foto_selfie') {
                            fotoSelfiePath = '';
                          } else if (field == 'foto_sertifikat') {
                            fotoSertifikatPath = '';
                          }
                        });
                      },
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
