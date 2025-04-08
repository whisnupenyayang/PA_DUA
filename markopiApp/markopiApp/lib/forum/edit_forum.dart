import 'dart:io';

import 'package:belajar_flutter/model/model_forum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class EditForumPage extends StatefulWidget {
  Forum forum;

  EditForumPage({required this.forum});

  @override
  _EditForumPageState createState() => _EditForumPageState();
}

class _EditForumPageState extends State<EditForumPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.forum.judulForum;
    _deskripsiController.text = widget.forum.deskripsiForum;
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
          'Edit Forum',
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
                  labelText: 'Judul Forum',
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
                'Deskripsi',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Forum',
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
                  : widget.forum.imageUrls.isNotEmpty
                      ? Image.network(
                          widget.forum.imageUrls.first,
                          height: 200,
                        )
                      : SizedBox.shrink(),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  _updateForum();
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

  Future<void> _updateForum() async {
    try {
      String imageUrl =
          widget.forum.imageUrls.isNotEmpty ? widget.forum.imageUrls.first : '';

      if (_image != null) {
        final response = await http.post(
          Uri.parse(
              'http://192.168.43.233:8000/api/upload_image'), // adjust the endpoint for image upload
          body: {'image': base64Encode(_image!.readAsBytesSync())},
        );

        if (response.statusCode == 200) {
          imageUrl = response.body; // use the returned image URL
        } else {
          throw 'Failed to upload image';
        }
      }

      final response = await http.put(
        Uri.parse('http://192.168.43.233:8000/api/artikel/${widget.forum.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': _judulController.text,
          'deskripsi': _deskripsiController.text,
          'user_id': widget.forum.userId,
          'image_url': imageUrl,
          'tanggal': widget.forum.tanggal,
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
        Forum forumBaru = Forum(
          id: widget.forum.id,
          judulForum: _judulController.text,
          deskripsiForum: _deskripsiController.text,
          userId: widget.forum.userId,
          tanggal: widget.forum.tanggal,
          imageUrls: [imageUrl],
        );

        setState(() {
          widget.forum = forumBaru;
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
