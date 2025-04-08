import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticlePage extends StatelessWidget {
  final dynamic articleData;

  ArticlePage({required this.articleData});

  @override
  Widget build(BuildContext context) {
    var judul = articleData.judulArtikel;
    var isi = articleData.isiArtikel;
    var imageUrl =
        articleData.imageUrls.isNotEmpty ? articleData.imageUrls[0] : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Artikel',
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.justify, // Rata kiri
                ),
                SizedBox(height: 4),
                Text(
                  articleData.tanggal,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Memberikan sedikit ruang antara teks "Bahan" dan konten HTML
                Html(
                  data: isi,
                  style: {
                    "body": Style(
                        textAlign: TextAlign
                            .justify), // Setting the text alignment to justify
                    "ul": Style(fontSize: FontSize(16.0)),
                    "p": Style(fontSize: FontSize(16.0)),
                    "li": Style(fontSize: FontSize(16.0)),
                    "ol": Style(fontSize: FontSize(16.0)),
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.thumb_up),
          //       onPressed: () {
          //         // Tambahkan logika untuk tindakan suka di sini
          //       },
          //     ),
          //     Text('Suka'),
          //     SizedBox(width: 20),
          //     IconButton(
          //       icon: Icon(Icons.thumb_down),
          //       onPressed: () {
          //         // Tambahkan logika untuk tindakan tidak suka di sini
          //       },
          //     ),
          //     Text('Tidak Suka'),
          //   ],
          // ),
          SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Komentar',
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20.0,
          //         ),
          //       ),
          //       SizedBox(height: 10),
          //       SizedBox(
          //         width: double.infinity,
          //         child: TextField(
          //           maxLines: 4,
          //           decoration: InputDecoration(
          //             hintText: 'Tambahkan komentar',
          //             border: OutlineInputBorder(),
          //             contentPadding: EdgeInsets.all(10),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
