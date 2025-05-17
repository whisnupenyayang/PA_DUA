import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // tambah ini
import 'package:markopi/controllers/Forum_Controller.dart';

class TambahPertanyaan extends StatefulWidget {
  const TambahPertanyaan({Key? key}) : super(key: key);

  @override
  State<TambahPertanyaan> createState() => _TambahPertanyaanState();
}

class _TambahPertanyaanState extends State<TambahPertanyaan> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();

  final ForumController forumController = Get.find();

  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      forumController.tambahForum(
        judulForum: _judulController.text,
        deskripsiForum: _deskripsiController.text,
        imagePath: _pickedImage?.path,
      );
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pertanyaan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Pertanyaan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty
                    ? 'Deskripsi wajib diisi'
                    : null,
              ),
              const SizedBox(height: 16),
              _pickedImage != null
                  ? Image.file(_pickedImage!, height: 150)
                  : const SizedBox(),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Pilih Gambar (Opsional)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Kirim Pertanyaan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
