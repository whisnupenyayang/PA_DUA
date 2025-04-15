import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:markopi/providers/Pengepul_Providers.dart';

class TokoKopi extends StatefulWidget {
  const TokoKopi({super.key});

  @override
  State<TokoKopi> createState() => _TokoKopiState();
}

class _TokoKopiState extends State<TokoKopi> {
  // final api = Get.put(PengepulProviders());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 100,
          width: 200,
          color: Colors.grey,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(14, 80, 14, 0), // 16 jarak dari atas
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(13.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 159,
                      color: Colors.black,
                      // decoration: BoxDecoration(),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Pasar Porsea',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Rp 36.000/kg',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('200 kunjungi'),
                          Text('200 kunjungi'),
                          Text('200 kunjungi'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
