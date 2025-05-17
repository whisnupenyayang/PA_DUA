import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Forum_Controller.dart';
import 'package:markopi/models/Forum_Model.dart';

class KomenPage extends StatefulWidget {
  final Forum forum;

  const KomenPage({super.key, required this.forum});

  @override
  State<KomenPage> createState() => _KomenPageState();
}

class _KomenPageState extends State<KomenPage> {
  final ForumController forumC = Get.put(ForumController());
  final TextEditingController _komentar = TextEditingController();
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi komentar untuk forum ini
    forumC.komentarForum.clear();
    forumC.forumDetail.value = widget.forum; // bisa set langsung dari parameter
    forumC.fetchKomentar(widget.forum.id); // ambil komentar forum ini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Komentar'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.forum.judulForum,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Oleh: ${widget.forum.user.namaLengkap}',
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.forum.tanggal,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  if (widget.forum.imageUrls.isNotEmpty)
                    ...widget.forum.imageUrls.map(
                      (url) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CachedNetworkImage(
                          imageUrl: 'http://10.0.2.2:8000/storage/$url',
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    widget.forum.deskripsiForum,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),

                  // Daftar komentar
                  Text(
                    'Komentar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    if (forumC.komentarForum.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text("Belum ada komentar"),
                      );
                    }

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: forumC.komentarForum.length,
                      itemBuilder: (context, index) {
                        var komentar = forumC.komentarForum[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 20,
                                // Bisa pakai foto profil jika ada
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    komentar.komentar.trim(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),

          // Input komentar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, -2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _komentar,
                        decoration: InputDecoration(
                          hintText: "Tulis komentar...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: isSending
                          ? null
                          : () async {
                              String komentar = _komentar.text.trim();
                              if (komentar.isNotEmpty) {
                                setState(() => isSending = true);
                                await forumC.buatKomentar(komentar, widget.forum.id);
                                _komentar.clear();
                                setState(() => isSending = false);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: isSending
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
