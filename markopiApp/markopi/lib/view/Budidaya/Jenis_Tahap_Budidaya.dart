import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Budidaya_Controller.dart';
import 'package:markopi/controllers/Kegiatan_Controller.dart';
import 'package:markopi/routes/route_name.dart';
import './Jenis_Tahap_Budidaya_Detail.dart';
import 'package:markopi/providers/Connection.dart';
import 'package:cached_network_image/cached_network_image.dart';

class JenisTahapBudidayaView extends StatefulWidget {
  @override
  State<JenisTahapBudidayaView> createState() => _JenisTahapBudidayaViewState();
}

class _JenisTahapBudidayaViewState extends State<JenisTahapBudidayaView> {
  final KegiatanController kegiatanC = Get.put(KegiatanController());
  final BudidayaController budidayaC = Get.put(BudidayaController());
  int? id;

  @override
  void initState() {
    super.initState();
    try {
      id = int.parse(Get.parameters['id']!);
    } catch (e) {
      id = null;
    }

    if (id != null) {
      budidayaC.jenisTahapBudidayaList.clear();
      kegiatanC.fetchJenisTahapanKegiatan(id!);
      // budidayaC.fetchJenisTahapBudidaya(id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("ID tidak valid")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Jenis Tahap Budidaya"),
      ),
      body: Obx(() {
        if (kegiatanC.jenisTahapKegiatanList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: kegiatanC.jenisTahapKegiatanList.length,
          itemBuilder: (context, index) {
            final item = kegiatanC.jenisTahapKegiatanList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteName.kegiatan +
                    '/jenistahapanbudidaya/detail/${item.id}');
              },
              child: Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 8,
                        height: 100,
                        color: Colors.black,
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://192.168.150.244:8000/storage/${item.url_gambar}',
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.judul ?? 'Tanpa Judul',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.chevron_right, size: 30),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
