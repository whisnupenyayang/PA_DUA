import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/connection.dart';
import 'package:belajar_flutter/autentikasi/auth_manager_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Request body
    Map<String, String> data = {
      'username': username,
      'password': password,
    };

    // API endpoint
    String loginUrl = Connection.buildUrl('/login');
    print('Login URL: $loginUrl');

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: data,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(response.body); // Pastikan ini benar
        if (responseData['success']) {
          // Ambil data dari response
          final Map<String, dynamic> userData = responseData['data'];
          print("test3");

          // Ambil nilai yang dibutuhkan
          int id = userData['id_users']; // Pastikan ini benar
          String role = userData['role'];

          await AuthManager.login(id, userData['nama_lengkap'], role);
          print("test1");

          // Simpan role ke SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('role', role);
          print("test2");

          // Arahkan ke halaman yang sesuai
          if (role == 'petani') {
            Navigator.pushReplacementNamed(context, '/beranda_petani');
          } else if (role == 'fasilitator') {
            Navigator.pushReplacementNamed(context, '/beranda_fasilitator');
          } else if (role == 'admin') {
            Navigator.pushReplacementNamed(context, '/beranda_admin');
          } else {
            print("Peran tidak dikenali");
          }
        } else {
          print("Login gagal: ${responseData['message']}");
        }
      } else {
        print("Login gagal");
      }
    } catch (error) {
      print('Error: $error');

      print('Error: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat melakukan login.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          title: Text(
            "MARKOPI",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 30,
              fontFamily: 'Khula',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/beranda');
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Daftar',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  obscureText: _isObscure,
                ),
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/forgot_password');
                    },
                    child: Text('Lupa Kata Sandi?'),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(200, 50),
                  backgroundColor: Color(0xFF142B44),
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}
