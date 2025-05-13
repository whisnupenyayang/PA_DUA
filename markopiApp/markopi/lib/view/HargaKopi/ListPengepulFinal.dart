import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markopi/controllers/Pengepul_Controller.dart';
import 'package:markopi/providers/Connection.dart';
import 'package:markopi/routes/route_name.dart';
import 'package:markopi/test.dart';
import 'package:markopi/view/HargaKopi/PengepulDetail.dart';

import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class KopiPage extends StatefulWidget {
  @override
  _KopiPageState createState() => _KopiPageState();
}

class _KopiPageState extends State<KopiPage> {
  bool isPengepul = true; // untuk toggle antara pengepul dan petani

  final PengepulController pengepulC = Get.put(PengepulController());
  @override
  void initState() {
    super.initState();
    pengepulC.fetchPengepul();
  }

  @override
  Widget build(BuildContext context) {
    String role = isPengepul ? 'pengepul' : 'petani';

    return Scaffold(
      appBar: AppBar(
        title: Text(isPengepul ? 'Pengepul' : 'Petani'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ayo!! Temukan harga terbaik untuk Kopi Anda.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPengepul = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPengepul ? Colors.brown : Colors.grey,
                  ),
                  child: Text('Pengepul'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPengepul = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isPengepul ? Colors.brown : Colors.grey,
                  ),
                  child: Text('Petani'),
                ),
              ],
            ),
            SizedBox(height: 12),
            SimpleLineChart(),
            SizedBox(height: 12),
            Obx(() {
              return MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: pengepulC.pengepul.length,
                itemBuilder: (context, index) {
                  final item = pengepulC.pengepul[index];
                  return GestureDetector(
                    onTap: () {
                      print(item.url_gambar);
                      Get.toNamed(RouteName.pengepul + '/detail/$role');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  Connection.buildImageUrl(item.url_gambar),
                              height: 150 +
                                  (index % 2) *
                                      30, // bikin tinggi gambar sedikit acak
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.nama_toko ?? '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 16, color: Colors.grey),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(item.alamat ?? '',
                                          style: TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${item.harga}',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  isPengepul
                                      ? 'Sudah dibeli: 45'
                                      : 'Sudah dijual: 23',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
