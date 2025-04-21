import 'dart:ffi';

import 'package:flutter/material.dart';

class JenisTahapBudidayDetailView extends StatefulWidget {
  const JenisTahapBudidayDetailView({super.key});

  @override
  State<JenisTahapBudidayDetailView> createState() =>
      _JenisTahapBudidayDetailViewState();
}

class _JenisTahapBudidayDetailViewState
    extends State<JenisTahapBudidayDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("makanan"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Pembukaan Lahan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 21),
              Container(
                height: 181,
                color: Colors.grey,
              ),
              SizedBox(height: 14),
              Text(
                "Pembongkaran pohon-pohon, tunggul beserta perakarannya.Pembongkaran tanaman perdu dan pembersihan gulma.  Pembukaan lahan tanpa pembakaran dan penggunaan herbisida secara  bijaksana. Sebagian tanaman kayu-kayuan yang diameternya < 30 cm  dapat ditinggalkan sebagai penaung tetap dengan populasi 200-500  pohon/ha diusahakan dalam arah Utara-Selatan. Jika memungkinkan  tanaman kayu-kayuan yang ditinggalkan sebagai penaung tetap  memiliki nilai ekonomi tinggi.Pembersihan lahan, kayu-kayu ditumpuk di satu tempat di pinggir  kebun. Gulma dapat dibersihkan secara manual maupun secara kimiawi  menggunakan herbisida sistemik maupun kontak tergantung jenis  gulmanya secara bijaksana. Pembuatan jalan-jalan produksi (jalan setapak) dan saluran drainase. Pembuatan teras-teras pada lahan yang memiliki kemiringan lebih dari  30%.",
                // (Isi teks panjang kamu di sini)

                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 14),
              Container(
                height: 186,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
