import 'package:belajar_flutter/artikel/artikel.dart';
import 'package:belajar_flutter/minuman/minuman.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:belajar_flutter/connection.dart';
import 'package:belajar_flutter/model/model_artikel.dart';
import 'package:belajar_flutter/model/model_minuman.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BerandaFasilitator extends StatefulWidget {
  @override
  _BerandaFasilitatorState createState() => _BerandaFasilitatorState();
}

class _BerandaFasilitatorState extends State<BerandaFasilitator> {
  int? userId;
  final String? username = AuthManager.getUsername();
  final String? nama_lengkap = AuthManager.getUsername();
  late List<dynamic> _data = [];
  String? imageUrl;
  int _selectedIndex = 0;
  String? currentDate;

  @override
  void initState() {
    super.initState();
    userId = AuthManager.getUserId();
    print('User ID: $userId');
    _fetchDataFromApi(); //
    getCurrentDate();
  }

  void getCurrentDate() {
    DateTime now = DateTime.now();
    currentDate = '${now.day} ${_getMonthName(now.month)} ${now.year}';
  }

  String _getMonthName(int month) {
    const List<String> monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return monthNames[month - 1];
  }

  Future<void> _fetchDataFromApi() async {
    try {
      var response = await http.get(Uri.parse(Connection.buildUrl('/artikel')));
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
          if (_data.isNotEmpty) {
            imageUrl = _data[0]['images'][0]['url'];
          }
        });
      } else {
        print('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigasi ke halaman beranda
        Navigator.pushReplacementNamed(context, '/beranda_fasilitator');
        break;
      case 1:
        // Navigasi ke halaman komunitas
        Navigator.pushReplacementNamed(context, '/fasilitator_list_forum');
        break;
      case 2:
        // Navigasi ke halaman notifikasi
        Navigator.pushReplacementNamed(context, '/notifikasi_fasilitator');
        break;
      case 3:
        // Navigasi ke halaman profil
        Navigator.pushReplacementNamed(context, '/profil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MARKOPI",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Khula',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF142B44),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Horas $username',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(16),
              color: Color(0xFFFD4ECFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "25°C",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Berawan",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Laguboti, $currentDate",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.cloud_queue,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'User ID: $userId',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       SizedBox(height: 5),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 5), // Spasi antara card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildHorizontalCard(
                  "BUDIDAYA",
                  "assets/images/budidaya.png",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/budidaya');
                  },
                ),
                buildHorizontalCard(
                  "PANEN",
                  "assets/images/panen.png",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/panen');
                  },
                ),
                buildHorizontalCard(
                  "PASCA PANEN",
                  "assets/images/pasca_panen.png",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/pasca_panen');
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Kedai Kopi',
                    style:
                        TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () async {
                      const url =
                          'https://www.google.com/maps/search/kedai+kopi+terdekat/@3.5913654,98.6710013,12z/data=!3m1!4b1?entry=ttu'; // Ganti dengan URL Google Maps yang sesuai untuk lokasi Kedai Kopi
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                        ); // Buka tautan menggunakan package url_launcher
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      'Jelajahi',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 20, 20, 20),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 290, // Atur tinggi slider sesuai kebutuhan Anda
                enableInfiniteScroll:
                    true, // Aktifkan scroll tak terbatas // Aktifkan otomatis memutar slide
              ),
              items: [
                'assets/images/par.jpg', // Ganti dengan path gambar pertama dari penyimpanan lokal
                'assets/images/pulp.jpeg', // Ganti dengan path gambar kedua dari penyimpanan lokal
                'assets/images/tab.jpg', // Ganti dengan path gambar ketiga dari penyimpanan lokal
                // tambahkan path gambar lainnya sesuai kebutuhan Anda
              ].map((String imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Atur padding card sesuai kebutuhan
                      child: Card(
                        elevation: 8, // Tambahkan elevasi untuk efek shadow
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              5), // Atur border radius card sesuai kebutuhan
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal:
                      0.0), // Mengatur padding atas dan bawah // Mengatur lebar atas dan bawah
              child: Container(
                color: Color(0xFFD4ECFF),
                padding:
                    const EdgeInsets.all(8.0), // Padding di dalam container
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Artikel',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/fasilitator_list_artikel');
                            },
                            child: Text(
                              'Lihat Semua',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 20, 20, 20),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buildHorizontalListView(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Minuman',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/list_minuman');
                    },
                    child: Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 20, 20, 20),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: MinumanList(),
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF142B44), // Background color
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
          selectedItemColor: Colors.amber[800],
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget buildHorizontalListView() {
    return FutureBuilder<List<Artikel>>(
      future: fetchArtikel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Ambil 4 artikel pertama
          List<Artikel> firstFourArtikels = snapshot.data!.take(4).toList();
          return SizedBox(
            height: 200, // Atur tinggi sesuai kebutuhan Anda
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: firstFourArtikels.length,
              itemBuilder: (BuildContext context, int index) {
                Artikel artikel = firstFourArtikels[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(articleData: artikel),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    color: Colors.white, // Mengatur warna card menjadi putih
                    elevation: 2, // Tambahkan elevasi untuk efek shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Tambahkan border radius
                    ),
                    child: Container(
                      width: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    // ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        artikel.imageUrls.first,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    color: Colors.black.withOpacity(0.7),
                                    child: Text(
                                      artikel.judulArtikel,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                      ),
                                      textAlign: TextAlign.justify,
                                      maxLines: 2, // Batasi menjadi 2 baris
                                      overflow: TextOverflow
                                          .ellipsis, // Tambahkan overflow ellipsis
                                    ),
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
              },
            ),
          );
        }
      },
    );
  }

  Widget MinumanList() {
    return FutureBuilder<List<Minuman>>(
      future: fetchMinuman(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Ambil 4 artikel pertama
          List<Minuman> firstFourMinuman = snapshot.data!.take(4).toList();
          return SizedBox(
            height: 200, // Atur tinggi sesuai kebutuhan Anda
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: firstFourMinuman.length,
              itemBuilder: (BuildContext context, int index) {
                Minuman minuman = firstFourMinuman[index];
                double screenWidth = MediaQuery.of(context).size.width;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MinumanPage(minumanData: minuman),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    color: Color(
                        0xFFD4ECFF), // Warna card diubah menjadi biru muda
                    elevation: 2, // Tambahkan elevasi untuk efek shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Tambahkan border radius
                    ),
                    child: Container(
                      width: screenWidth -
                          8, // Kurangi sedikit untuk margin horizontal
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                minuman.imageUrls.first,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 12.0), // Tambah padding vertikal
                            child: Text(
                              minuman.namaMinuman,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                              textAlign: TextAlign.justify,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget buildHorizontalCard(String title, String imagePath,
      {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        child: Card(
          color: Color(0xFFD4ECFF),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D508D),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Artikel>> fetchArtikel() async {
    final response = await http.get(Uri.parse(Connection.buildUrl('/artikel')));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Artikel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<List<Minuman>> fetchMinuman() async {
    final response = await http.get(Uri.parse(Connection.buildUrl('/minuman')));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Minuman.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
