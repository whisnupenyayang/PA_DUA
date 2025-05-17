import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Forum_Controller.dart';
import 'komen.dart'; // pastikan import halaman komen
import 'TambahPertanyaan.dart';

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
    forumController.fetchForum();
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
          controller: _scrollController,
          itemCount:
              forumController.forum.length + (forumController.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < forumController.forum.length) {
              final forum = forumController.forum[index];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 39,
                              height: 39,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              forum.user.namaLengkap ?? 'Loading...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              forum.imageUrls.isNotEmpty
                                  ? Container(
                                      height: 300,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: forum
                                            .imageUrls[0], // Gunakan image asli
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      height: 165,
                                      width: double.infinity,
                                      color: Colors.black12,
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      forum.judulForum,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      forum.deskripsiForum,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(() => KomenPage(forum: forum));
                                        },
                                        child: const Text('Selengkapnya'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const TambahPertanyaan());
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Pertanyaan',
      ),
    );
  }
}
