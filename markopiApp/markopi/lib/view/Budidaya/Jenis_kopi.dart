import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:get/get.dart';
import 'package:markopi/routes/route_name.dart';

class BudidayaView extends StatelessWidget {
  final List<String> kopiList = ['Arabika', 'Robusta'];
=======
import 'package:markopi/view/Budidaya/Menu.dart';

class Budidaya extends StatelessWidget {
  const Budidaya({super.key});
>>>>>>> b7d988b14595090ff7890c8ed522634798f81a43

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
<<<<<<< HEAD
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
=======
                itemCount: 2, // Menampilkan 2 jenis kopi
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menampilkan nama kopi sesuai index
                      Text(
                        i == 0 ? 'Kopi Arabika' : 'Kopi Robusta',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 172,
                              color: Colors.blue,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Navigasi ke Menu.dart ketika tombol Mulai ditekan
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Menu(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Mulai',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
>>>>>>> b7d988b14595090ff7890c8ed522634798f81a43
                                    ),
                                  ),
                                ),
                              ],
                            ),
<<<<<<< HEAD
                          ),
                        ),
                      ],
                    ),
                  );
                },
=======
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
>>>>>>> b7d988b14595090ff7890c8ed522634798f81a43
              ),
            ),
          ],
        ),
      ),
    );
  }
}
