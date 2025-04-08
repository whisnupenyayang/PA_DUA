import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailPengelolaanPage extends StatelessWidget {
  final dynamic data;

  DetailPengelolaanPage({required this.data});

  @override
  Widget build(BuildContext context) {
    var tahapan = data['tahapan'];
    var deskripsi = data['deskripsi'];
    var link = data['link'];
    var imageUrl = data['images'][0]['url']; // Ambil URL gambar pertama saja

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Budidaya',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF142B44),
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
