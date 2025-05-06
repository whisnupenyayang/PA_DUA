import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Pengepul_Controller.dart';
import 'package:markopi/models/Pengepul_Model.dart';
import 'package:markopi/test.dart';
import 'package:markopi/view/component/MyBottomNavigation.dart';

class ListPengepul extends StatefulWidget {
  const ListPengepul({super.key});

  @override
  State<ListPengepul> createState() => _ListPengepulState();
}

class _ListPengepulState extends State<ListPengepul> {
  final PengepulController pengepulC = Get.put(PengepulController());

  @override
  void initState() {
    super.initState();
    pengepulC.fetchPengepul();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengepul'),
      ),
      body: Obx(() {
        return ListView(
          padding: EdgeInsets.all(16),
          children: [
            SimpleLineChart(),
            SizedBox(height: 20),
            ...pengepulC.pengepul.map((p) => Column(
                  children: [
                    PengepulCard(pengepul: p),
                    SizedBox(height: 50),
                  ],
                )),
          ],
        );
      }),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFFFFFFFF)),
        child: const MyBottomNavigationBar(),
      ),
    );
  }
}

class PengepulCard extends StatelessWidget {
  final Pengepul pengepul;

  const PengepulCard({super.key, required this.pengepul});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            constraints: BoxConstraints(
              minHeight: 160,
            ),
            width: double.infinity, // biar gambar memenuhi lebar
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: 'http://10.0.2.2:8000/${pengepul.url_gambar}',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover, // agar gambar mengisi area
              ),
            ),
          ),
          SizedBox(height: 10),

          // Nama Toko
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pengepul.nama_toko,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // Info Kopi
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pengepul.jenis_kopi,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Rp. ${pengepul.harga}/kg",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          // Informasi
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Informasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, size: 20),
                    SizedBox(width: 8),
                    Text(
                      pengepul.nomor_telepon,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.place, size: 20),
                    SizedBox(width: 8),
                    Text(
                      pengepul.alamat,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
