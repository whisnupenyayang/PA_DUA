import 'package:belajar_flutter/model/model_forum.dart';
import 'package:belajar_flutter/model/model_replies.dart';
import 'package:belajar_flutter/model/model_user.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../autentikasi/auth_manager_page.dart';
import '../connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailKomunitasPage extends StatefulWidget {
  final dynamic forumData;

  DetailKomunitasPage({required this.forumData});

  @override
  _DetailKomunitasPageState createState() => _DetailKomunitasPageState();
}

class _DetailKomunitasPageState extends State<DetailKomunitasPage> {
  final TextEditingController _commentController = TextEditingController();
  List<dynamic> _comments = [];
  bool _isLiked = false;
  int _likeCount = 0;
  bool _isDisliked = false;
  int _dislikeCount = 0;
  late Future<List<Replies>> futureReplies;
  late Future<Map<int, User>> futureUsers;
  late Future<List<Forum>> futureForums;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
    futureReplies = fetchReplies();
    futureForums = fetchForums();
    _fetchComments();
    _checkIfLiked();
    _checkIfDisliked();
    _fetchLikeCount(); // Panggil _fetchLikeCount() di sini untuk mengambil jumlah like awal
    _loadDislikeCount();
  }

  Future<void> _loadLikeCount() async {
    final prefs = await SharedPreferences.getInstance();
    final likeCount = prefs.getInt('likeCount_${widget.forumData.id}') ?? 0;
    setState(() {
      _likeCount = likeCount;
    });
  }

  Future<List<Forum>> fetchForums() async {
    final response = await http.get(Uri.parse(Connection.buildUrl('/forum')));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Forum.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data forum');
    }
  }

  Future<List<Replies>> fetchReplies() async {
    final response =
        await http.get(Uri.parse(Connection.buildUrl('/getAllReplies')));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> data =
          responseData['data']; // Adjust this line if your key is different
      return data.map((json) => Replies.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data replies');
    }
  }

  Future<Map<int, User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse(Connection.buildUrl('/getAllUser')));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> usersJson = data['data']; // Access the 'data' key
      List<User> users = usersJson.map((json) => User.fromJson(json)).toList();
      return {for (var user in users) user.id: user};
    } else {
      throw Exception('Gagal memuat data pengguna');
    }
  }

  Future<void> _checkIfLiked() async {
    final prefs = await SharedPreferences.getInstance();
    final isLiked = prefs.getBool('isLiked_${widget.forumData.id}');
    if (isLiked != null) {
      setState(() {
        _isLiked = isLiked;
      });
    }
  }

  Future<void> _loadDislikeCount() async {
    final prefs = await SharedPreferences.getInstance();
    final dislikeCount =
        prefs.getInt('dislikeCount_${widget.forumData.id}') ?? 0;
    setState(() {
      _dislikeCount = dislikeCount;
    });
  }

  Future<void> _checkIfDisliked() async {
    final prefs = await SharedPreferences.getInstance();
    final isDisliked = prefs.getBool('isDisliked_${widget.forumData.id}');
    if (isDisliked != null) {
      setState(() {
        _isDisliked = isDisliked;
      });
    }
  }

  Future<void> _fetchComments() async {
    final url =
        Uri.parse(Connection.buildUrl('/forumKomen/${widget.forumData.id}'));
    print('Fetching comments from: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _comments = jsonDecode(response.body)['data'];
        });

        for (var comment in _comments) {
          await _fetchReplies(comment['id'].toString());
        }
      } else {
        print('Failed to load comments: ${response.body}');
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  Future<void> _fetchReplies(String commentId) async {
    final url = Uri.parse(Connection.buildUrl('/replies/$commentId'));
    print('Fetching replies from: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          final replies = jsonDecode(response.body)['data'];
          int commentIndex = _comments
              .indexWhere((comment) => comment['id'].toString() == commentId);
          if (commentIndex != -1) {
            if (replies.isEmpty) {
              _comments[commentIndex]['replies'] = ["Tidak ada balasan"];
            } else {
              _comments[commentIndex]['replies'] = replies;
            }
          }
        });
      } else {
        print('Failed to load replies: ${response.body}');
        throw Exception('Failed to load replies');
      }
    } catch (e) {
      print('Error fetching replies: $e');
    }
  }

  Future<void> submitComment(
      String comment, String forumId, String userId) async {
    final url = Uri.parse(Connection.buildUrl('/forum_comment/$forumId'));
    print('URL: $url');
    print('Payload: ${jsonEncode(<String, String>{
          'komentar': comment,
          'forum_id': forumId,
          'user_id': userId,
        })}');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'komentar': comment,
          'forum_id': forumId,
          'user_id': userId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Komentar berhasil ditambahkan');
        _fetchComments();
      } else {
        throw Exception('Failed to submit comment: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to submit comment: $e');
    }
  }

  Future<void> likeForum(String forumId, String userId) async {
    final url = Uri.parse(Connection.buildUrl('/forum/$forumId/like/$userId'));
    print('Liking forum with URL: $url');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        if (responseData['status'] == 'success') {
          setState(() {
            if (responseData['message'] == 'Like added') {
              _isLiked = true;
              _likeCount += 1;
              prefs.setBool('isLiked_$forumId', true);
            } else if (responseData['message'] == 'Like removed') {
              _isLiked = false;
              _likeCount -= 1;
              prefs.remove('isLiked_$forumId');
            }
          });
        } else {
          throw Exception('Failed to like forum: ${response.body}');
        }
      } else {
        throw Exception('Failed to like forum: ${response.body}');
      }
      // Panggil _fetchLikeCount() setelah status like diperbarui
      await _fetchLikeCount();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to like forum: $e');
    }
  }

  Future<void> _toggleDislike() async {
    try {
      int? userId = AuthManager.getUserId();
      if (userId != null) {
        final url = Uri.parse(Connection.buildUrl(
            '/forum/${widget.forumData.id}/dislike/$userId'));
        print('Disliking forum with URL: $url');

        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final prefs = await SharedPreferences.getInstance();
          if (responseData['status'] == 'success') {
            if (responseData['message'] == 'Dislike added') {
              setState(() {
                _isDisliked = true;
                _dislikeCount += 1;
              });
              prefs.setBool('isDisliked_${widget.forumData.id}', true);
            } else if (responseData['message'] == 'Dislike removed') {
              setState(() {
                _isDisliked = false;
                _dislikeCount -= 1;
              });
              prefs.remove('isDisliked_${widget.forumData.id}');
            }
          } else {
            throw Exception('Failed to dislike forum: ${response.body}');
          }
        } else {
          throw Exception('Failed to dislike forum: ${response.body}');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not found')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to dislike forum: $e')),
      );
    }
  }

  Future<void> _fetchLikeCount() async {
    final url =
        Uri.parse(Connection.buildUrl('/forum/${widget.forumData.id}/likes'));
    print('Fetching like count from: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final likeCount = responseData['data']['likes'];
        setState(() {
          _likeCount = likeCount;
        });

        // Simpan jumlah like ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('likeCount_${widget.forumData.id}', likeCount);
      } else {
        print('Failed to load like count: ${response.body}');
        throw Exception('Failed to load like count');
      }
    } catch (e) {
      print('Error fetching like count: $e');
    }
  }

  Future<void> submitReply(
      String reply, String commentId, String userId) async {
    final url = Uri.parse(Connection.buildUrl('/replies'));
    print('URL: $url');
    print('Payload: ${jsonEncode(<String, String>{
          'komentar': reply,
          'komentar_id': commentId,
          'user_id': userId,
        })}');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'komentar': reply,
          'komentar_id': commentId,
          'user_id': userId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('Balasan berhasil ditambahkan');
        _fetchComments();
      } else {
        throw Exception('Failed to submit reply: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to submit reply: $e');
    }
  }

  void _showReplyDialog(String commentId) {
    final TextEditingController _replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Balas Komentar'),
          content: TextField(
            controller: _replyController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Tambahkan balasan',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_replyController.text.isNotEmpty) {
                  try {
                    int? userId = AuthManager.getUserId();
                    if (userId != null) {
                      await submitReply(
                        _replyController.text,
                        commentId,
                        userId.toString(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Balasan berhasil dikirim')),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User tidak ditemukan')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal mengirim balasan: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Balasan tidak boleh kosong')),
                  );
                }
              },
              child: Text('Kirim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var judul = widget.forumData.judulForum;
    var deskripsi = widget.forumData.deskripsiForum;
    var imageUrl = widget.forumData.imageUrls.isNotEmpty
        ? widget.forumData.imageUrls[0]
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Forum',
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
      body: ListView(
        children: [
          if (imageUrl != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 200,
                width: double.infinity,
                child: buildImageWidget(imageUrl),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Color(0xFF2696D6), // Warna Biru
                  size: 40, // Ukuran ikon
                ),
                SizedBox(width: 8), // Jarak antara ikon profil dan nama lengkap
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<Map<int, User>>(
                      future: futureUsers,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return Text('No data');
                        } else {
                          final users = snapshot.data!;
                          final user = users[widget.forumData.userId];
                          final userName = user?.namaLengkap ?? 'Unknown User';
                          return Text(
                            userName,
                            style: TextStyle(
                              color: Color(0xFF2696D6), // Warna Biru
                              fontSize: 20, // Ukuran teks username
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                        height: 4), // Jarak antara nama lengkap dan tanggal
                    Text(
                      widget.forumData.tanggal,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              deskripsi,
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 20),
          Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                  color: _isLiked ? Colors.blue : Colors.black,
                ),
                onPressed: () async {
                  int? userId = AuthManager.getUserId();
                  if (userId != null) {
                    try {
                      await likeForum(
                        widget.forumData.id.toString(),
                        userId.toString(),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to like forum: $e')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User not found')),
                    );
                  }
                },
              ),
              Text('$_likeCount'),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  _isDisliked
                      ? Icons.thumb_down
                      : Icons.thumb_down_alt_outlined,
                  color: _isDisliked ? Colors.blue : Colors.black,
                ),
                onPressed: () async {
                  // Panggil fungsi toggleDislike ketika tombol dislike ditekan
                  await _toggleDislike();
                },
              ),
              Text('$_dislikeCount'),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Komentar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10),
                ..._comments.map((comment) => Column(
                      children: [
                        ListTile(
                          title: FutureBuilder<Map<int, User>>(
                            future: futureUsers,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData) {
                                return Text('No data');
                              } else {
                                final users = snapshot.data!;
                                final user_id = int.parse(comment['user_id']
                                    .toString()); // Parse user_id ke int
                                final user = users[user_id];
                                final userName =
                                    user?.namaLengkap ?? 'Unknown User';
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person),
                                        SizedBox(width: 8),
                                        Text(
                                          userName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              35.0), // Adjust the left padding here
                                      child: Text(comment['komentar']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              20.0), // Same left padding for buttons
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              _showReplyDialog(
                                                  comment['id'].toString());
                                            },
                                            child: Text('Reply'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (comment['replies'] == null) {
                                                _fetchReplies(
                                                    comment['id'].toString());
                                              } else {
                                                setState(() {
                                                  comment['showReplies'] =
                                                      !(comment[
                                                              'showReplies'] ??
                                                          false);
                                                });
                                              }
                                            },
                                            child: Text(
                                                comment['replies'] == null
                                                    ? 'Show Replies'
                                                    : (comment['showReplies'] ==
                                                            true
                                                        ? 'Hide Replies'
                                                        : 'Show Replies')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        if (comment['replies'] != null &&
                            comment['showReplies'] == true)
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: Column(
                              children: (comment['replies'] is List &&
                                      comment['replies'].isEmpty)
                                  ? [Text("Tidak ada balasan")]
                                  : comment['replies'].map<Widget>((reply) {
                                      if (reply is String) {
                                        return ListTile(title: Text(reply));
                                      } else {
                                        return FutureBuilder<Map<int, User>>(
                                          future: futureUsers,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else if (!snapshot.hasData) {
                                              return Text('No data');
                                            } else {
                                              final users = snapshot.data!;
                                              final user_id = int.parse(reply[
                                                      'user_id']
                                                  .toString()); // Parse user_id ke int
                                              final user = users[user_id];
                                              final userName =
                                                  user?.namaLengkap ??
                                                      'Unknown User';
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left:
                                                        32.0), // More indented
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: Row(
                                                    children: [
                                                      Icon(Icons.person,
                                                          size: 16),
                                                      SizedBox(width: 8),
                                                      Text(userName),
                                                    ],
                                                  ),
                                                  subtitle: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left:
                                                            24.0), // More indented
                                                    child:
                                                        Text(reply['komentar']),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }
                                    }).toList(),
                            ),
                          ),
                        Divider(),
                      ],
                    )),
                SizedBox(height: 10),
                TextField(
                  controller: _commentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Tambahkan komentar',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        if (_commentController.text.isNotEmpty) {
                          try {
                            int? userId = AuthManager.getUserId();
                            if (userId != null) {
                              await submitComment(
                                _commentController.text,
                                widget.forumData.id.toString(),
                                userId.toString(),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Komentar berhasil dikirim')),
                              );
                              _commentController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('User tidak ditemukan')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Gagal mengirim komentar: $e')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Komentar tidak boleh kosong')),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildImageWidget(String? imageUrl) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox();
    }
  }
}
