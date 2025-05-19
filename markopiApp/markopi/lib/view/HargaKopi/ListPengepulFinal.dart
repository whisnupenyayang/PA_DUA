import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markopi/controllers/Pengepul_Controller.dart';
import 'package:markopi/providers/Connection.dart';
import 'package:markopi/routes/route_name.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class KopiPage extends StatefulWidget {
  @override
  _KopiPageState createState() => _KopiPageState();
}

class _KopiPageState extends State<KopiPage> {
  bool isPengepul = true;

  final PengepulController pengepulC = Get.put(PengepulController());

  @override
  void initState() {
    super.initState();
    pengepulC.fetchPengepul();
  }

  Future<void> _refreshData() async {
    await pengepulC.fetchPengepul(); // Pastikan fungsi ini async di controller
  }

  @override
  Widget build(BuildContext context) {
    String role = isPengepul ? 'pengepul' : 'petani';

    return Scaffold(
      appBar: AppBar(
        title: Text(isPengepul ? 'Pengepul' : 'Petani'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          physics: AlwaysScrollableScrollPhysics(), // wajib agar RefreshIndicator aktif
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ayo!! Temukan harga terbaik untuk Kopi Anda.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
                       Get.toNamed(RouteName.pengepul + '/detail/${item.id}');
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: CachedNetworkImage(
                                imageUrl: Connection.buildImageUrl(item.url_gambar),
                                height: 150 + (index % 2) * 30,
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
                                      style: TextStyle(fontWeight: FontWeight.bold)),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.pengepul + '/tambah');
        },
        backgroundColor: Colors.brown,
        child: Icon(Icons.add),
      ),
    );
  }
}
