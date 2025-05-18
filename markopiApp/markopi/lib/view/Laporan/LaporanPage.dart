import 'package:flutter/material.dart';
import 'package:markopi/service/laporan_service.dart';
import 'package:markopi/models/laporan.dart';
import 'package:get/get.dart';
import 'package:markopi/view/laporan/AddLaporanPage.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  late Future<List<Laporan>> _laporanList;

  @override
  void initState() {
    super.initState();
    _laporanList = LaporanService.getAllLaporans()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Laporan')),
      body: FutureBuilder<List<Laporan>>(
        future: _laporanList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          final laporanList = snapshot.data!;
          if (laporanList.isEmpty) {
            return const Center(child: Text('Belum ada laporan'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: laporanList.length,
            itemBuilder: (context, index) {
              final laporan = laporanList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  title: Text(
                    laporan.judulLaporan,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        laporan.isiLaporan ?? '-',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.description,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddLaporanPage());
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Laporan',
      ),
    );
  }
}
