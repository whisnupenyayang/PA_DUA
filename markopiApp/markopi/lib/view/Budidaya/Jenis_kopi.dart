import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/route_name.dart';

class BudidayaView extends StatelessWidget {
  final List<String> kopiList = ['Arabika', 'Robusta'];

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: kopiList.length,
                itemBuilder: (context, i) {
                  final jenisKopi = kopiList[i];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jenisKopi,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () => Get.toNamed('${RouteName.budidaya}/$jenisKopi'),
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                Container(
                                  height: 172,
                                  width: double.infinity,
                                  color: Colors.blue, // bisa diganti Image.asset
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
