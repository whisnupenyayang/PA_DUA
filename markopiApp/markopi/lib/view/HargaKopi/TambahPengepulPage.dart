import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markopi/controllers/Pengepul_Controller.dart';

class TambahPengepulPage extends StatefulWidget {
  @override
  _TambahPengepulPageState createState() => _TambahPengepulPageState();
}

class _TambahPengepulPageState extends State<TambahPengepulPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  final PengepulController pengepulC = Get.find();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        Get.snackbar('Gagal', 'Gambar belum dipilih');
        return;
      }

      pengepulC.tambahPengepul(
        nama: namaController.text,
        alamat: alamatController.text,
        harga: hargaController.text,
        gambar: _image!,
      );
      Get.back(); // kembali ke halaman sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengepul'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Center(child: Text('Pilih Gambar')),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Toko'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama toko harus diisi' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) =>
                    value!.isEmpty ? 'Alamat harus diisi' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: hargaController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Harga harus diisi' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              )
            ],
          ),
        ),
      ),
    );
  }
}
