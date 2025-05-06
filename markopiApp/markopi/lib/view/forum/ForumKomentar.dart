import 'package:flutter/material.dart';
import 'package:markopi/controllers/Forum_Controller.dart';
import 'package:get/get.dart';
import 'package:markopi/models/Budidaya_Model.dart';
import 'package:markopi/models/Forum_Model.dart';

class ForumKomentar extends StatefulWidget {
  const ForumKomentar({super.key});

  @override
  State<ForumKomentar> createState() => _ForumKomentarState();
}

class _ForumKomentarState extends State<ForumKomentar> {
  bool isSending = false;

  final ForumController forumC = Get.put(ForumController());
  final TextEditingController _komentar = TextEditingController();

  int? id;

  void initState() {
    super.initState();
    final idParam = Get.parameters['id'];
    id = int.tryParse(idParam ?? '');

    if (id != null) {
      forumC.komentarForum.clear();
      forumC.fetchKomentar(id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("ID tidak Valid"),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Komentar'),
      ),
      body: Column(
        children: [
          // Bagian atas forum (header)
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
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
                        Text("Username",
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                          Container(
                            height: 165,
                            width: double.infinity,
                            color: Colors.black12,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ada masalah Pada Daun Kopi Saya',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Pada daun kopi saya ada bercak kuning yang menempel...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Bagian komentar dengan loading indicator
          Expanded(
            child: Obx(() {
              return forumC.komentarForum.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 10),
                      itemCount: forumC.komentarForum.length,
                      itemBuilder: (context, index) {
                        var komentar = forumC.komentarForum[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 47,
                                  width: 47,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      komentar.komentar.trim(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }),
          ),

          // Bagian input komentar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: isSending
                          ? null
                          : () async {
                              String komentar = _komentar.text;
                              if (komentar.isNotEmpty && id != null) {
                                setState(() {
                                  isSending = true;
                                });
                                await forumC.buatKomentar(komentar, id!);
                                _komentar.clear();
                                setState(() {
                                  isSending = false;
                                });
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(14),
                      ),
                      child: isSending
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(Icons.send),
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

  String formatTanggal(String tanggal) {
    try {
      DateTime parsed = DateTime.parse(tanggal);
      return "${parsed.day}/${parsed.month}/${parsed.year} ${parsed.hour}:${parsed.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return tanggal;
    }
  }
}
