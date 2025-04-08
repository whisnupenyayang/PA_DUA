import 'dart:async';
import 'package:flutter/material.dart';

class PenjualanPage extends StatefulWidget {
  @override
  _PenjualanPageState createState() => _PenjualanPageState();
}

class _PenjualanPageState extends State<PenjualanPage> {
  @override
  void initState() {
    super.initState();
    // Menampilkan alert setelah 0.5 detik
    Timer(Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: contentBox(context),
          );
        },
      );
    });
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
            bottom: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue, // Warna latar belakang alert
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Opss...........",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Warna teks judul
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sedang Dalam Proses Pembuatan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white, // Warna teks konten
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Tunggu update lanjutannya.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white, // Warna teks konten
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Warna teks tombol
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Markopi',
          style: TextStyle(
            color: Colors.white, // Warna teks di AppBar
          ),
        ),
        backgroundColor: Color(0xFF65451F),
        leading: IconButton(
          onPressed: () {
            // Navigasi ke ProsesBudidayaPage dan menggantikan halaman saat ini
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Ganti dengan path gambar sesuai kebutuhan
            fit: BoxFit.cover,
          ),
        ),
        child: AbsorbPointer(
          absorbing: true, // Halaman dalam keadaan non-interaktif
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  'Penjualan Page',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Card(
                    elevation: 4.0,
                    margin: EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/Rumah.png', // Ganti dengan path gambar sesuai kebutuhan
                      width: 400.0,
                      height: 400.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
