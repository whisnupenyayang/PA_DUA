import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Forum_Controller.dart';
import 'package:markopi/models/Forum_Model.dart';

class ListForum extends StatelessWidget {
  final forumController = Get.put(ForumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forum')),
      body: Obx(() {
        if (forumController.isLoading.value && forumController.forum.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: forumController.forum.length + (forumController.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < forumController.forum.length) {
              final forum = forumController.forum[index];
              return ListTile(
                title: Text(forum.judulForum),
                subtitle: Text(forum.deskripsiForum),
                onTap: () {
                  // Menavigasi ke halaman forum detail jika diperlukan
                },
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
          // Tambah forum atau lakukan navigasi
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
