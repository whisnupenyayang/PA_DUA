// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DetailPolaTanamPage extends StatelessWidget {
//   final dynamic data;

//   DetailPolaTanamPage({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     var tahapan = data['tahapan'];
//     var deskripsi = data['deskripsi'];
//     var link = data['link'];
//     var sumberArtikel = data['sumber_artikel'];
//     var creditGambar = data['credit_gambar'];
//     var imageUrls = List<String>.from(
//       data['images'].map((image) => image['url']),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(tahapan),
//         backgroundColor: Color(0xFF65451F),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 5,
//                 margin: EdgeInsets.symmetric(vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         tahapan,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text('Deskripsi: $deskripsi'),
//                     ],
//                   ),
//                 ),
//               ),
//               Card(
//                 elevation: 5,
//                 margin: EdgeInsets.symmetric(vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Sumber Artikel: $sumberArtikel'),
//                     ],
//                   ),
//                 ),
//               ),
//               if (imageUrls.length > 2)
//                 Card(
//                   elevation: 5,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: CarouselSlider.builder(
//                       itemCount: (imageUrls.length / 2).ceil(),
//                       options: CarouselOptions(
//                         height: 150.0,
//                         enlargeCenterPage: true,
//                         autoPlay: true,
//                         aspectRatio: 16 / 9,
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enableInfiniteScroll: true,
//                         autoPlayAnimationDuration: Duration(milliseconds: 800),
//                         viewportFraction: 0.8,
//                       ),
//                       itemBuilder: (BuildContext context, int carouselIndex,
//                           int carouselInnerIndex) {
//                         int firstImageIndex = carouselIndex * 2;
//                         int secondImageIndex = firstImageIndex + 1;

//                         if (secondImageIndex < imageUrls.length) {
//                           // Jika ada dua gambar
//                           return Row(
//                             children: [
//                               Expanded(
//                                 child: Image.network(
//                                   imageUrls[firstImageIndex],
//                                   height: 150,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Expanded(
//                                 child: Image.network(
//                                   imageUrls[secondImageIndex],
//                                   height: 150,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           );
//                         } else {
//                           // Jika tinggal satu gambar, tampilkan secara penuh
//                           return Image.network(
//                             imageUrls[firstImageIndex],
//                             height: 150,
//                             width: double.infinity,
//                             fit: BoxFit.contain,
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 )
//               else if (imageUrls.length == 2)
//                 Card(
//                   elevation: 5,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Image.network(
//                             imageUrls.length > 0 ? imageUrls[0] : '',
//                             height: 150,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Image.network(
//                             imageUrls.length > 1 ? imageUrls[1] : '',
//                             height: 150,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               else if (imageUrls.length == 1)
//                 Card(
//                   elevation: 5,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Image.network(
//                       imageUrls[0],
//                       height: 150,
//                       width: double.infinity,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               Card(
//                 elevation: 5,
//                 margin: EdgeInsets.symmetric(vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Credit Gambar: $creditGambar'),
//                     ],
//                   ),
//                 ),
//               ),
//               Card(
//                 elevation: 5,
//                 margin: EdgeInsets.symmetric(vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Link:'),
//                       GestureDetector(
//                         onTap: () {
//                           _launchYouTubeLink(link);
//                         },
//                         child: Text(
//                           link,
//                           style: TextStyle(
//                             color: Colors.blue,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Divider(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Fungsi untuk membuka tautan YouTube di aplikasi YouTube atau browser
//   void _launchYouTubeLink(String url) async {
//     try {
//       if (await canLaunch(url)) {
//         await launch(url, forceSafariVC: false);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailPolaTanamPage extends StatelessWidget {
  final dynamic data;

  DetailPolaTanamPage({required this.data});

  @override
  Widget build(BuildContext context) {
    var tahapan = data['tahapan'];
    var deskripsi = data['deskripsi'];
    var link = data['link'];
    var imageUrl = data['images'][0]['url']; // Ambil URL gambar pertama saja

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Kesesuaian Lahan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF2696D6),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(imageUrl, tahapan),
              SizedBox(
                  height:
                      16), // Tambahkan ruang antara gambar dan langkah-langkah
              _buildTahapan(tahapan, deskripsi, link),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTahapan(String tahapan, String deskripsi, String link) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            data: deskripsi,
            style: {
              'p': Style(
                fontSize: FontSize(16.0),
                margin: Margins.only(left: 3.0),
                textAlign: TextAlign.left,
              ),
              'li': Style(
                fontSize: FontSize(16.0),
                margin: Margins.only(left: 3.0),
                textAlign: TextAlign.left,
              ),
            },
          ),
          SizedBox(height: 15), // Tambahkan ruang atas
          Text(
            'Video',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildYoutubeThumbnail(link),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl, String tahapan) {
    if (imageUrl.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 15),
          child: Center(
            child: Text(
              tahapan,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 10), // Tambahkan ruang antara judul dan gambar
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildYoutubeThumbnail(String youtubeUrl) {
    final String videoId = YoutubePlayer.convertUrlToId(youtubeUrl)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
            ),
            builder: (context, player) {
              return player;
            },
          ),
        ),
        FutureBuilder<String?>(
          future: _getVideoTitle(youtubeUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Future<String?> _getVideoTitle(String youtubeUrl) async {
    var id = YoutubePlayer.convertUrlToId(youtubeUrl);
    var yt = YoutubeExplode();
    try {
      var video = await yt.videos.get(id!);
      return video.title;
    } catch (e) {
      print('Error fetching video title: $e');
      return null;
    } finally {
      yt.close();
    }
  }
}
