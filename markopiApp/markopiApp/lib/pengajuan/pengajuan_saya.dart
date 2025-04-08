import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:belajar_flutter/model/model_pengajuan.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';

class PengajuanSayaPage extends StatefulWidget {
  @override
  _PengajuanSayaPageState createState() => _PengajuanSayaPageState();
}

class _PengajuanSayaPageState extends State<PengajuanSayaPage> {
  List<PengajuanData> _pengajuan = [];
  bool _isLoading = false;
  PengajuanData? _selectedPengajuan;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final userId = AuthManager.getUserId();
      if (userId != null) {
        final response = await http.get(
          Uri.parse('https://www.markopi.cloud/api/pengajuanById/$userId'),
        );
        if (response.statusCode == 200) {
          final List<dynamic> responseData = jsonDecode(response.body);
          setState(() {
            _pengajuan = responseData
                .map((json) => PengajuanData.fromJson(json))
                .toList();
          });
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('User not logged in');
      }
    } catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    // Memeriksa apakah pengajuan terakhir diterima saat halaman dimuat
    if (_pengajuan.isNotEmpty && _pengajuan.last.status == '1') {
      // Menampilkan Snackbar
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Pengajuan Anda telah diterima. Silahkan keluar aplikasi, lalu login lagi.'),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Tutup',
              onPressed: () {
                // Action saat Snackbar ditutup
              },
            ),
          ),
        );
      });
    }
  }

  void _viewDetails(PengajuanData pengajuan) {
    setState(() {
      _selectedPengajuan = pengajuan;
    });
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedPengajuan!.fotoKtpUrl != null)
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          _selectedPengajuan!.fotoKtpUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                if (_selectedPengajuan!.fotoSelfieUrl != null)
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          _selectedPengajuan!.fotoSelfieUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                if (_selectedPengajuan!.fotoSertifikatUrl != null)
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          _selectedPengajuan!.fotoSertifikatUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16.0),
                Text(
                  'Deskripsi Pengalaman:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  _selectedPengajuan!.deskripsiPengalaman,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Status:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: getColorForStatus(_selectedPengajuan!.status),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    getStatusText(_selectedPengajuan!.status),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getStatusText(String status) {
    switch (status) {
      case '0':
        return 'Menunggu ';
      case '1':
        return 'Diterima';
      case '2':
        return 'Ditolak';
      default:
        return 'Unknown';
    }
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case '0':
        return Colors.grey; // Warna abu-abu untuk status menunggu
      case '1':
        return Colors.green; // Warna hijau untuk status diterima
      case '2':
        return Colors.red; // Warna merah untuk status ditolak
      default:
        return Colors.black; // Warna default untuk status tidak dikenal
    }
  }

  @override
  Widget build(BuildContext context) {
    // Membuat variabel untuk menyimpan status pengajuan terakhir
    String lastSubmissionStatus =
        _pengajuan.isNotEmpty ? _pengajuan.last.status : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengajuan Saya',
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pengajuan.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 22.0,
                    columns: [
                      DataColumn(label: Text('#')),
                      DataColumn(label: Text('Deskripsi Pengalaman')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: _pengajuan
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) => entry.key % 2 == 0
                                  ? Color.fromRGBO(
                                      180, 236, 255, 1) // Warna biru muda
                                  : Color.fromRGBO(255, 255, 255, 1),
                            ),
                            cells: [
                              DataCell(
                                Text((entry.key + 1)
                                    .toString()), // Displaying numbers
                              ),
                              DataCell(
                                GestureDetector(
                                  onTap: () => _viewDetails(entry.value),
                                  child: Text(
                                    entry.value.deskripsiPengalaman.length > 33
                                        ? '${entry.value.deskripsiPengalaman.substring(0, 33)}...'
                                        : entry.value.deskripsiPengalaman,
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color:
                                        getColorForStatus(entry.value.status),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    getStatusText(entry.value.status),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
              : Center(
                  child: Text(
                    'Tidak ada Pengajuan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
      floatingActionButton: lastSubmissionStatus == '1'
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pengajuan');
              },
              backgroundColor: Color(0xFF142B44),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
    );
  }
}
