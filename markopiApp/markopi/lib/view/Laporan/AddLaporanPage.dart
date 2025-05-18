import 'package:flutter/material.dart';
import 'package:markopi/service/laporan_service.dart';
import 'package:markopi/models/laporan.dart';
import 'package:get/get.dart';
import 'package:markopi/service/token_storage.dart'; // Ensure TokenStorage is used to get the logged-in user

class AddLaporanPage extends StatefulWidget {
  const AddLaporanPage({Key? key}) : super(key: key);

  @override
  State<AddLaporanPage> createState() => _AddLaporanPageState();
}

class _AddLaporanPageState extends State<AddLaporanPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();

  // Fungsi untuk menyimpan laporan
  Future<void> _submitLaporan() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userId =
            await TokenStorage.getUserId(); // Fetch userId from TokenStorage

        if (userId == null) {
          Get.snackbar('Error', 'User ID tidak ditemukan');
          return;
        }

        final laporan = Laporan(
          id: 0,
          judulLaporan: _judulController.text,
          isiLaporan:
              _isiController.text.isNotEmpty ? _isiController.text : null,
          userId: userId,
          userName:
              'User', // << Tambahkan nilai default atau ambil dari token jika tersedia
        );

        await LaporanService.addLaporan(laporan);
        Get.snackbar('Sukses', 'Laporan berhasil ditambahkan');
        Get.back(); // Kembali ke halaman sebelumnya
      } catch (e) {
        Get.snackbar('Gagal', 'Gagal menambahkan laporan: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Laporan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Use the form key to validate the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul Laporan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul laporan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isiController,
                decoration: const InputDecoration(labelText: 'Isi Laporan'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isi laporan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitLaporan,
                child: const Text('Simpan Laporan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
