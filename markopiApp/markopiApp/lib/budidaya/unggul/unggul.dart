// // kesesuaian lahan.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_unggul_page.dart';
import 'package:belajar_flutter/connection.dart'; // Import file connection.dart

class UnggulPage extends StatefulWidget {
  @override
  _UnggulPageState createState() => _UnggulPageState();
}

class _UnggulPageState extends State<UnggulPage> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchDataUsers();
  }

  Future<List<dynamic>> _fetchDataUsers() async {
    var result = await http.get(Uri.parse(Connection.buildUrl(
        '/budidaya/bahan_tanam_unggul+'))); // Menggunakan Connection.buildUrl()
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bahan Tanam Unggul',
          style: TextStyle(
            color: Colors.white, // Warna teks di AppBar
          ),
        ),
        backgroundColor: Color(0xFF142B44),
        leading: IconButton(
          onPressed: () {
            // Navigasi ke halaman sebelumnya
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Bahan Tanam Unggul',
                style: TextStyle(
                  fontSize: 24, // Ukuran font 24
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _futureData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data[index];
                        var tahapan = data['tahapan'];
                        var imageUrls = List<String>.from(data['images'].map(
                            (image) => image['url'])); // List of image URLs

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailUnggulPage(data: data),
                                  ),
                                );
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  imageUrls.isNotEmpty
                                      ? imageUrls[0]
                                      : '', // Menggunakan URL gambar pertama jika tersedia
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                tahapan,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
                            Divider(), // Menambahkan divider sebagai pembatas setiap item
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'detail_pola_tanam_page.dart';

// class KesesuaianLahanPage extends StatelessWidget {
//   final String apiUrl = "http://127.0.0.1:8000/api/budidaya/pola_tanam";

//   Future<List<dynamic>> _fecthDataUsers() async {
//     var result = await http.get(Uri.parse(apiUrl));
//     return json.decode(result.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kesesuaian Lahan'),
//         backgroundColor: Color(0xFF65451F),
//       ),
//       // Tambahkan background image
//       backgroundColor: Colors.transparent,
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//                 'assets/images/background.png'), // Ganti dengan path gambar yang diinginkan
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: FutureBuilder<List<dynamic>>(
//           future: _fecthDataUsers(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return Align(
//                 alignment: Alignment.topCenter,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: List.generate(
//                       snapshot.data.length,
//                       (index) {
//                         var data = snapshot.data[index];
//                         var tahapan = data['tahapan'];

//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPolaTanamPage(data: data),
//                                   ),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 primary: Color(0xFF8E745C), // Warna tombol
//                                 alignment: Alignment.centerLeft, // Rata kiri
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   tahapan,
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: Colors.white, // Warna teks putih
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }