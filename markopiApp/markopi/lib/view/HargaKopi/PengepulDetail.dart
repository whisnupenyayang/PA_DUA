import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markopi/controllers/PengajuanTransaksi_Controller.dart';

import 'package:get/get.dart';
import 'package:markopi/controllers/Pengepul_Controller.dart';

class DetailPengepuldanPetani extends StatefulWidget {
  @override
  _DetailPengepuldanPetaniState createState() =>
      _DetailPengepuldanPetaniState();
}

class _DetailPengepuldanPetaniState extends State<DetailPengepuldanPetani> {
  final PengajuanTransaksiController pengajuanC =
      Get.put(PengajuanTransaksiController());

  final PengepulController pengepulC = Get.put(PengepulController());

  String? role;
  @override
  void initState() {
    super.initState();
    role = Get.parameters['role'];
    
    pengepulC.fetchPengepulByUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pengepul"),
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl:
                    'http://10.0.2.2:8000/storage/budidayaimage/OjPcIQh71iVEIq6A2wk3Z1AuZh73KgFTX9JQOWtP.png',
                // bikin tinggi gambar sedikit acak
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'UD. Kopi Selamat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Sudah dibeli: 45'),
            SizedBox(height: 4),
            Text(
              'Klik disini untuk melihat riwayat pembelian',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _buildInfoRow('Nama Pengepul', 'Elisabeth P.'),
                    _buildInfoRow('Jenis Kopi', 'Arabika dan Robusta'),
                    _buildInfoRow('Gabon (Biji Basah)', 'Rp. 6.500,00'),
                    _buildInfoRow('Green Bean (Kotor)', 'Rp. 8.000,00'),
                    _buildInfoRow('Green Bean (Bersih Kopi)', 'Rp. 9.000,00'),
                    _buildInfoRow('Gabah (Biji Basah)', 'Rp. 5.000,00'),
                    _buildInfoRow('Alamat', 'Pintubosi, Laguboti'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hubungi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('📞 0812-3456-7890'),
            SizedBox(height: 8),
            ElevatedButton.icon(
              icon: Icon(Icons.chat),
              label: Text("Buka WhatsApp"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Bisa tambahkan open WhatsApp intent atau deep link
              },
            ),
            SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print(role);
                  pengajuanC.buatpengajuan(1, role!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text("Jual Kopi"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
