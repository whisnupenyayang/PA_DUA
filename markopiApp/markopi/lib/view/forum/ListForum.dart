import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Forum_Controller.dart';
import 'package:markopi/routes/route_name.dart';
import '../component/MyBottomNavigation.dart';

class ListForum extends StatefulWidget {
  const ListForum({super.key});

  @override
  _ListForumState createState() => _ListForumState();
}

class _ListForumState extends State<ListForum> {
  final forumController = Get.put(ForumController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    forumController.fetchForum(); // panggil fetch pertama kali

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        forumController.fetchForum();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forum')),
      body: Obx(() {
        if (forumController.forum.isEmpty && forumController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: _scrollController, // pasang controller di ListView
          itemCount:
              forumController.forum.length + (forumController.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < forumController.forum.length) {
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
                            Icon(
                              Icons.account_circle,
                              color: Color(0xFF2696D6),
                              size: 40,
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (forum.user.namaLengkap ?? 'Loading...')
                                        .toString(),
                                    style: TextStyle(
                                      color: Color(0xFF2696D6),
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    forum.tanggal,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
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
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.thumb_up),
                                onPressed: () {},
                              ),
                              Text('Suka',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.thumb_down),
                                onPressed: () {},
                              ),
                              Text('Tidak Suka',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.comment),
                                onPressed: () {
                                  Get.toNamed(
                                      RouteName.forumkomen + '/${forum.id}');
                                },
                              ),
                              Text('Komentar',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Ini loader untuk halaman berikutnya
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
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
