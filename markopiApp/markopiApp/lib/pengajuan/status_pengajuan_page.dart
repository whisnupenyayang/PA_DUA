import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../autentikasi/auth_manager_page.dart';

class StatusPengajuanPage extends StatefulWidget {
  @override
  _StatusPengajuanPageState createState() => _StatusPengajuanPageState();
}

class _StatusPengajuanPageState extends State<StatusPengajuanPage> {
  late int? petaniId;
  int statusPengajuan = 0; // Status default, misalnya 0: Menunggu Persetujuan

  @override
  void initState() {
    super.initState();
    initPetaniId();
  }

  Future<void> initPetaniId() async {
    petaniId = await AuthManager.getUserId();
    setState(() {});
  }

  Future<void> getStatusFromApi() async {
    try {
      if (petaniId == null) {
        // Handle jika petaniId null
        return;
      }

      final response = await http.get(
        Uri.parse(
            'http://192.168.43.233:8000/api/pengajuan_status/${petaniId}'),
      );

      if (response.statusCode == 200) {
        // Berhasil mendapatkan data dari API
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          statusPengajuan = data['status'];
        });
      } else {
        // Gagal mendapatkan data dari API
        print(
            'Gagal mendapatkan data dari API. Status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String statusText =
        statusPengajuan == 0 ? 'Menunggu Persetujuan' : 'Sudah di Approve';

    return Scaffold(
      appBar: AppBar(
        title: Text('Status Pengajuan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Status Pengajuan'),
                    content: Text(statusText),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Tutup dialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Lihat Status Pengajuan'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF142B44),
        onPressed: () {
          Navigator.pushNamed(
              context, '/pengajuan'); // Navigasi ke route /pengajuan
        },
        child: Icon(
          Icons.add,
          color: Colors.white, // Warna ikon diubah menjadi putih
        ),
      ),
    );
  }
}
