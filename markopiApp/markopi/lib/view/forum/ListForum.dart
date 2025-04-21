import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Forum_Controller.dart';
import 'package:markopi/routes/route_name.dart';
import '../component/MyBottomNavigation.dart';

class ListForum extends StatelessWidget {
  ListForum({super.key});

  final forumController = Get.put(ForumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forum')),
      body: Obx(() {
        if (forumController.forum.isEmpty) {
          print('kosong');
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: forumController.forum.length,
          itemBuilder: (context, index) {
            final forum = forumController.forum[index];

            return GestureDetector(
              onTap: () {
                print('tertekan');
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (forum.imageUrls.isNotEmpty)
                      Image.network(
                        forum.imageUrls.first,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon User
                          Icon(
                            Icons.account_circle,
                            color: Color(0xFF2696D6), // Warna Biru
                            size: 40, // Ukuran ikon
                          ),
                          SizedBox(width: 8.0), // Spacer
                          // Informasi Tanggal dan Username
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Username
                                Text(
                                  (forum.user.namaLengkap ?? 'Loading...')
                                      .toString(),
                                  style: TextStyle(
                                    color: Color(0xFF2696D6),
                                    fontSize: 20,
                                  ),
                                ),
                                // Tanggal
                                Text(
                                  forum.tanggal,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8.0), // Spacer
// Padding di sekitar judul forum
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        forum.judulForum,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        forum.deskripsiForum,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Divider(thickness: 1),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Like Button
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_up),
                              onPressed: () {
                                // Handle like action
                              },
                            ),
                            Text(
                              'Suka',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        // Dislike Button
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_down),
                              onPressed: () {
                                // Handle dislike action
                              },
                            ),
                            Text(
                              'Tidak Suka',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        // Comment Button
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.comment),
                              onPressed: () {
                                Get.toNamed(RouteName.forumkomen + '/1');
                              },
                            ),
                            Text(
                              'Komentar',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFFFFFFFF)),
        child: const MyBottomNavigationBar(),
      ),
    );
  }
}
