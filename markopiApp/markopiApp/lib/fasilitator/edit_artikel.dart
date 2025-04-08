import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:belajar_flutter/model/model_artikel.dart';
import 'package:belajar_flutter/connection.dart';

class EditArtikelPage extends StatefulWidget {
  Artikel artikel;

  EditArtikelPage({required this.artikel});

  @override
  _EditArtikelPageState createState() => _EditArtikelPageState();
}

class _EditArtikelPageState extends State<EditArtikelPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.artikel.judulArtikel;
    _isiController.text = widget.artikel.isiArtikel;
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Artikel',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Judul',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul Artikel',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 12),
              Text(
                'Isi',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _isiController,
                decoration: InputDecoration(
                  labelText: 'Isi Artikel',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                maxLines: 10,
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                child: ElevatedButton.icon(
                  onPressed: _getImage,
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
              SizedBox(height: 12),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 200,
                    )
                  : widget.artikel.imageUrls.isNotEmpty
                      ? Image.network(
                          widget.artikel.imageUrls.first,
                          height: 200,
                        )
                      : SizedBox.shrink(),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  _updateArtikel();
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF142B44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateArtikel() async {
    try {
      String imageUrl = widget.artikel.imageUrls.isNotEmpty
          ? widget.artikel.imageUrls.first
          : '';

      if (_image != null) {
        final response = await http.post(
          Uri.parse(Connection.buildUrl(
              '/upload_image')), // Menggunakan kelas Connection untuk membangun URL
          body: {'image': base64Encode(_image!.readAsBytesSync())},
        );

        if (response.statusCode == 200) {
          imageUrl = response.body; // Menggunakan URL gambar yang dikembalikan
        } else {
          throw 'Failed to upload image';
        }
      }
      final response = await http.put(
        Uri.parse(Connection.buildUrl(
            '/artikel/${widget.artikel.id}')), // Menggunakan kelas Connection untuk membangun URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'judul_artikel': _judulController.text,
          'isi_artikel': _isiController.text,
          'user_id': widget.artikel.userId,
          'image_url': imageUrl,
          'tanggal': widget.artikel.tanggal,
        }),
      );

      if (response.statusCode == 200) {
        // Artikel berhasil diperbarui
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Artikel berhasil diperbarui'),
            backgroundColor: Colors.green,
          ),
        );

        // Update objek artikel
        Artikel artikelBaru = Artikel(
          id: widget.artikel.id,
          judulArtikel: _judulController.text,
          isiArtikel: _isiController.text,
          userId: widget.artikel.userId,
          tanggal: widget.artikel.tanggal,
          imageUrls: [imageUrl],
        );

        setState(() {
          widget.artikel = artikelBaru;
        });
      } else {
        // Gagal memperbarui artikel
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memperbarui artikel'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print(error.toString());
      // Tangani error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui artikel'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
