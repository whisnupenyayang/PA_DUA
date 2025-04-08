import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/connection.dart';
import 'package:belajar_flutter/model/model_forum.dart';
import 'package:belajar_flutter/model/model_user.dart';
import 'package:belajar_flutter/forum/detail_forum.dart';

class ListForumPetani extends StatefulWidget {
  @override
  _ListForumPetaniState createState() => _ListForumPetaniState();
}

class _ListForumPetaniState extends State<ListForumPetani> {
  int _selectedIndex = 1;
  late Future<List<Forum>> futureForums;
  late Future<Map<int, User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureForums = fetchForums();
    futureUsers = fetchUsers().then((users) {
      return {for (var user in users) user.id: user};
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

  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse(Connection.buildUrl('/getAllUser')));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> usersJson = data['data']; // Access the 'data' key
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data pengguna');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "FORUM",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Khula',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFF142B44),
        ),
        body: FutureBuilder<List<Forum>>(
          future: futureForums,
          builder: (context, forumSnapshot) {
            if (forumSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (forumSnapshot.hasError) {
              return Center(child: Text('Error: ${forumSnapshot.error}'));
            } else {
              return FutureBuilder<Map<int, User>>(
                future: futureUsers,
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasError) {
                    return Center(child: Text('Error: ${userSnapshot.error}'));
                  } else {
                    return buildListView(forumSnapshot.data, userSnapshot.data);
                  }
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/Addforum');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF142B44),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF142B44),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Komunitas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifikasi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profil',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            showUnselectedLabels: false,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/beranda_petani');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/petani_list_forum');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/notifikasi_petani');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profil_petani');
        break;
    }
  }

  Widget buildListView(List<Forum>? forums, Map<int, User>? users) {
    if (forums == null || forums.isEmpty) {
      return Center(child: Text("Tidak ada data"));
    }

    return ListView.builder(
      itemCount: forums.length,
      itemBuilder: (BuildContext context, int index) {
        Forum forum = forums[index];
        User? user = users?[forum.userId];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailKomunitasPage(forumData: forum),
              ),
            );
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
                              user?.namaLengkap ?? 'Loading...',
                              style: TextStyle(
                                color: Color(0xFF2696D6), // Warna Biru
                                fontSize: 20, // Ukuran teks username
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailKomunitasPage(forumData: forum),
                              ),
                            );
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
  }
}
