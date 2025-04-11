import 'package:belajar_flutter/fasilitator/artikel_saya.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:belajar_flutter/newberanda/Beranda.dart'; // Import kelas Beranda

class profil extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<profil> {
  int _selectedIndex = 3;
  bool _isLoading = false;
  Users? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      _isLoading = true;
    });

    await AuthManager.loadUser();

    if (mounted) {
      setState(() {
        user = AuthManager.getUser();
        _isLoading = false;
      });
    }
  }

  // Fungsi untuk logout
  void _logout() async {
    setState(() {
      _isLoading = true;
    });

    await AuthManager.logout();

    // Redirect ke halaman Beranda setelah logout
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Beranda()),
    );
  }

  // Menampilkan dialog konfirmasi logout
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text(
            "Apakah Anda yakin ingin keluar?",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF808080),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "BATAL",
                style: TextStyle(
                  color: Color(0xFF2696D6),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: Color(0xFF2696D6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // String userName =
    //     user?.username ?? ''; // Menggunakan user yang telah dideklarasikan

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFIL",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Khula',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF142B44),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ListView(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: AssetImage(
                            user!.jenisKelamin == 'Perempuan'
                                ? 'assets/images/woman.png'
                                : 'assets/images/man.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          user!.namaLengkap,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user!.username,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'Daftar Alamat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${user!.kabupaten}, ${user!.provinsi}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'Nomor Telepon',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user!.noTelp),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'E-mail',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user!.email),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'Jenis Kelamin',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user!.jenisKelamin),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'Tanggal Lahir',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user!.tanggalLahir),
                  ),
                  ListTile(
                    title: Text(
                      'Peranan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user!.role),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'Artikel Saya',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArtikelSayaPage()),
                      );
                    },
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'Forum Saya',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/forum_saya');
                    },
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text(
                      'Update Profil',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/update_profil_petani')
                          .then((_) {
                        // Memuat ulang data profil saat kembali ke halaman ini
                        _loadUser();
                      });
                    },
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    title: Text(
                      'Keluar',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: _showLogoutConfirmationDialog,
                  ),
                  Divider(thickness: 1),
                ],
              ),
      ),
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
          selectedItemColor: Colors.amber[800],
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/beranda_fasilitator');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/fasilitator_list_forum');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/notifikasi_fasilitator');
          break;
        case 3:
          _loadUser(); // Memuat ulang data profil saat menu Profil dipilih
          break;
      }
    }
  }
}
