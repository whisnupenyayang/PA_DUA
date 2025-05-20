import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Forum_Controller.dart';

class ListForum extends StatelessWidget {
  final ForumController forumController = Get.put(ForumController());

  ListForum() {
    debugPrint('ListForum: Widget constructed');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('ListForum: build method called');
    return Scaffold(
      appBar: AppBar(title: const Text('Forum')),
      body: RefreshIndicator(
        onRefresh: () {
          debugPrint('ListForum: Pull-to-refresh triggered');
          return forumController.refreshForum();
        },
        child: Obx(() {
          debugPrint('ListForum: Obx rebuild triggered, isLoading=${forumController.isLoading.value}, forumCount=${forumController.forum.length}');
          
          if (forumController.isLoading.value && forumController.forum.isEmpty) {
            debugPrint('ListForum: Showing loading indicator (first load)');
            return const Center(child: CircularProgressIndicator());
          }
          
          if (forumController.forum.isEmpty && !forumController.isLoading.value) {
            debugPrint('ListForum: No forums available to display');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tidak ada forum tersedia'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint('ListForum: Manual refresh button pressed');
                      forumController.refreshForum();
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }
          
          debugPrint('ListForum: Building ListView with ${forumController.forum.length} items');
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              // Check if we're at the bottom of the list
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                debugPrint('ListForum: Reached bottom of list, hasMore=${forumController.hasMore.value}, isLoading=${forumController.isLoading.value}');
                
                if (forumController.hasMore.value && !forumController.isLoading.value) {
                  debugPrint('ListForum: Triggering loadMore()');
                  forumController.loadMore();
                  return true;
                }
              }
              return false;
            },
            child: ListView.builder(
              itemCount: forumController.forum.length + (forumController.hasMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < forumController.forum.length) {
                  final forum = forumController.forum[index];
                  debugPrint('ListForum: Building item at index $index with id=${forum.id}, title=${forum.judulForum}');
                  
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text(forum.judulForum),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(forum.deskripsiForum),
                          const SizedBox(height: 4),
                          Text("Oleh: ${forum.user.namaLengkap}", 
                              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                          Text("Tanggal: ${forum.tanggal}", 
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      onTap: () {
                        // Navigate to forum detail
                        debugPrint('ListForum: Tapped on forum ${forum.id}');
                        Get.toNamed('/forumDetail', arguments: forum.id);
                      },
                    ),
                  );
                } else {
                  // This is the loading indicator at the bottom of the list
                  debugPrint('ListForum: Showing bottom loading indicator, isLoading=${forumController.isLoading.value}');
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: forumController.isLoading.value 
                          ? Column(
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 8),
                                Text('Memuat data...', style: Theme.of(context).textTheme.bodySmall),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }
              },
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add forum page
          debugPrint('ListForum: Add forum button pressed');
          Get.toNamed('/addForum');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}