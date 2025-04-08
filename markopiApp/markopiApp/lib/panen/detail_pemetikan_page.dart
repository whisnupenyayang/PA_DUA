import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:belajar_flutter/connection.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DetailPemetikanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchDataUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data![0];
          var tahapan = data['kategori'];
          var deskripsi = data['deskripsi'];
          var link = data['link'];
          // var sumberArtikel = data['sumber_artikel'];
          // var creditGambar = data['credit_gambar'];
          var imageUrl =
              data['images'][0]['url']; // Ambil URL gambar pertama saja

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Panen',
                style: TextStyle(
                  color: Colors.white, // Warna teks di AppBar
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(imageUrl, tahapan),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Html(
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
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'Video',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Text(
                    //     'Credit Gambar: $creditGambar',
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    _buildYoutubeThumbnail(link),
                    SizedBox(height: 16),
                    Divider(),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
          padding: EdgeInsets.only(top: 10, bottom: 10),
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

  Future<List<dynamic>> _fetchDataUsers() async {
    var result = await http.get(Uri.parse(Connection.buildUrl(
        '/panen/pemetikan'))); // Menggunakan Connection.buildUrl()
    return json.decode(result.body);
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
