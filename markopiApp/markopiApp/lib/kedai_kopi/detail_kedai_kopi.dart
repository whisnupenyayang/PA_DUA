// detail_page.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailKedaiKopiPage extends StatelessWidget {
  final dynamic data;

  DetailKedaiKopiPage({required this.data});

  @override
  Widget build(BuildContext context) {
    var nama_kedai = data['nama_kedai'];
    var alamat = data['alamat'];
    var jam_buka = data['jam_buka'];
    var jam_tutup = data['jam_tutup'];
    var hari_buka = data['hari_buka'];
    var hari_tutup = data['hari_tutup'];
    var no_telp = data['no_telp'];
    var credit_gambar = data['credit_gambar'];
    var imageUrls = List<String>.from(
      data['images'].map((image) => image['url']),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(nama_kedai),
        backgroundColor: Color(0xFF65451F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama_kedai,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Deskripsi: $alamat'),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$nama_kedai beroperasi pada:'),

                      // Informasi tambahan di dalam card
                      SizedBox(height: 8),
                      Text('$hari_buka - $hari_tutup'),
                      SizedBox(height: 8),
                      Text('$jam_buka - $jam_tutup'),
                      SizedBox(height: 12),
                      Text('$no_telp - $no_telp'),
                    ],
                  ),
                ),
              ),
              if (imageUrls.length > 2)
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CarouselSlider.builder(
                      itemCount: (imageUrls.length / 2).ceil(),
                      options: CarouselOptions(
                        height: 150.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                      itemBuilder: (BuildContext context, int carouselIndex,
                          int carouselInnerIndex) {
                        int firstImageIndex = carouselIndex * 2;
                        int secondImageIndex = firstImageIndex + 1;

                        if (secondImageIndex < imageUrls.length) {
                          // Jika ada dua gambar
                          return Row(
                            children: [
                              Expanded(
                                child: Image.network(
                                  imageUrls[firstImageIndex],
                                  height: 150,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Image.network(
                                  imageUrls[secondImageIndex],
                                  height: 150,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Jika tinggal satu gambar, tampilkan secara penuh
                          return Image.network(
                            imageUrls[firstImageIndex],
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          );
                        }
                      },
                    ),
                  ),
                )
              else if (imageUrls.length == 2)
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            imageUrls.length > 0 ? imageUrls[0] : '',
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Image.network(
                            imageUrls.length > 1 ? imageUrls[1] : '',
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (imageUrls.length == 1)
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.network(
                      imageUrls[0],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Credit Gambar: $credit_gambar'),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

