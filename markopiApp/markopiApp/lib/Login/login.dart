import 'dart:html';

import 'package:belajar_flutter/connection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Request body
    Map<String, String> data = {
      'username': username,
      'password': password,
    };

    String loginUrl = Connection.buildUrl('login');
    print('login Url :');

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        print("anjay sukses");
      }
    } catch (error) {
      print('Error : $error');

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
      appBar: AppBar(
        toolbarHeight: 88,
        titleSpacing: 20,
        centerTitle: true,
        title: Text("Masuk"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Email address",
                hintText: "Your email address",
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Your password",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Text(
                    _obscurePassword ? "Show" : "Hide",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2696D6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("Masuk", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2696D6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("Daftar", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
