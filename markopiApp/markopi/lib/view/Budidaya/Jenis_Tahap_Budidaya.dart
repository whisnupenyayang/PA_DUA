import 'package:flutter/material.dart';
import './Jenis_Tahap_Budidaya_Detail.dart';
import 'package:get/get.dart';

class JenisTahapBudidayaView extends StatefulWidget {
  const JenisTahapBudidayaView({super.key});

  @override
  State<JenisTahapBudidayaView> createState() => _JenisTahapBudidayaViewState();
}

class _JenisTahapBudidayaViewState extends State<JenisTahapBudidayaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hais"),
      ),
      body: ListView.builder(
        itemCount: 8, // jumlah pengulangan
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman detail pakai GetX
              Get.to(() => JenisTahapBudidayDetailView());
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 3 / 8,
                      height: 100,
                      color: Colors.black,
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
                              "Syarat Pohon Penaung",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 30,
                            ),
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
      ),
    );
  }
}
