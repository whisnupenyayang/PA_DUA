import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Forum_Controller.dart';

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
          itemCount: forumController.forum.length + (forumController.hasMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < forumController.forum.length) {
              final forum = forumController.forum[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(forum.judulForum),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(forum.deskripsiForum),
                      const SizedBox(height: 4),
                      Text("Oleh: ${forum.user.namaLengkap}", style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                      Text("Tanggal: ${forum.tanggal}", style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  onTap: () {
                    // Navigasi ke detail forum jika diinginkan
                  },
                ),
              );
            } else {
              // Indikator loading saat ambil data halaman berikutnya (infinite scroll)
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
          // Tambah forum atau navigasi ke form tambah
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
