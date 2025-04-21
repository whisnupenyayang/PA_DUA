import 'package:flutter/material.dart';
import 'package:markopi/controllers/Budidaya_Controller.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/route_name.dart';
import 'package:markopi/view/Budidaya/Tahap_Budidaya.dart';

class BudidayaView extends StatelessWidget {
  final BudidayaController budidayaC = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      budidayaC.fetchJenisKopi();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Budidaya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Jenis Kopi',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: budidayaC.jenisKopi.length,
                  itemBuilder: (context, i) {
                    final kopi = budidayaC.jenisKopi[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kopi.nama_kopi,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          InkWell(
                            onTap: () =>
                                Get.toNamed(RouteName.budidaya + '/${kopi.id}'),
                            borderRadius: BorderRadius.circular(10),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip
                                  .antiAlias, // penting biar radius Card berlaku ke semua anak
                              child: Column(
                                children: [
                                  Container(
                                    height: 172,
                                    width: double.infinity,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    color: Color(0xff142B44),
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: Text(
                                        'Mulai',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
