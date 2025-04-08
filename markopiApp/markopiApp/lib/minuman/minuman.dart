import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:flutter_html/flutter_html.dart';

class MinumanPage extends StatelessWidget {
  final dynamic minumanData;

  MinumanPage({required this.minumanData});

  @override
  Widget build(BuildContext context) {
    var nama = minumanData.namaMinuman;
    var bahan = minumanData.bahanMinuman;
    var langkah = minumanData.langkahMinuman;
    var credit = minumanData.creditGambar;
    var imageUrl =
        minumanData.imageUrls.isNotEmpty ? minumanData.imageUrls[0] : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Minuman',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF142B44),
        leading: IconButton(
          onPressed: () {
            // Navigasi ke halaman sebelumnya
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: [
          if (imageUrl != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 200, // Atur tinggi gambar
                width: double.infinity,
                child: buildImageWidget(imageUrl),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              credit,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey, // Menggunakan warna abu-abu
              ),
              textAlign: TextAlign.justify, // Rata kiri dan kanan
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.justify, // Rata kiri
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bahan bahan",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    height: 1.2, // Adjust line height for better readability
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                    height:
                        8), // Memberikan sedikit ruang antara teks "Bahan" dan konten HTML
                Html(
                  data: bahan,
                  style: {
                    "body": Style(
                        textAlign: TextAlign
                            .justify), // Setting the text alignment to justify
                    "ul": Style(fontSize: FontSize(16.0)),
                    "li": Style(fontSize: FontSize(16.0)),
                    "ol": Style(fontSize: FontSize(16.0)),
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Langkah langkah",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height:
                        8), // Memberikan sedikit ruang antara teks "Bahan" dan konten HTML
                Html(
                  data: langkah,
                  style: {
                    "ul": Style(fontSize: FontSize(16.0)),
                    "li": Style(fontSize: FontSize(16.0)),
                    "ol": Style(fontSize: FontSize(16.0)),
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildImageWidget(String? imageUrl) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox();
    }
  }
}
