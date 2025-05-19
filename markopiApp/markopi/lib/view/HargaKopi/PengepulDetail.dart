import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markopi/controllers/PengajuanTransaksi_Controller.dart';

import 'package:get/get.dart';
import 'package:markopi/controllers/Pengepul_Controller.dart';
import 'package:markopi/routes/route_name.dart';

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
    // Ambil id dari route parameter
    final idStr = Get.parameters['id'];
    final id =
        int.tryParse(idStr ?? '') ?? 1; // default 1 jika null atau gagal parse

    pengepulC.fetcPengepulDetail(id);
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
        child: Obx(() {
          var item = pengepulC.detailPengepul.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: CachedNetworkImage(
              //     imageUrl:
              //         'http://10.0.2.2:8000/storage/budidayaimage/OjPcIQh71iVEIq6A2wk3Z1AuZh73KgFTX9JQOWtP.png',
              //     // bikin tinggi gambar sedikit acak
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //     placeholder: (context, url) =>
              //         Center(child: CircularProgressIndicator()),
              //     errorWidget: (context, url, error) => Icon(Icons.error),
              //   ),
              // ),
              SizedBox(height: 12),
              Text(
                item.nama_toko,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Rp. ${item.harga}/Kg',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  
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
                    Get.toNamed(
                        RouteName.pengepul + '/pengajuan/role/${item.id}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Jual Kopi"),
                ),
              )
            ],
          );
        }),
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
