import 'dart:convert';
import 'package:belajar_flutter/beranda.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'connection.dart'; // Import kelas Connection yang sudah ada

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _resetPassword() async {
    final String apiUrl = Connection.buildUrl(
        '/password/reset'); // Menggunakan buildUrl dari Connection

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': emailController.text.trim(),
          'otp': otpController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        bool success = responseData['succees'] ??
            false; // Pastikan key 'succees' benar sesuai response dari server

        if (success) {
          // Tampilkan pesan sukses atau lakukan navigasi ke halaman login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password berhasil direset, refresh kembali app'),
              duration: Duration(seconds: 5),
            ),
          );

          // Navigasi ke halaman login atau halaman lain setelah reset password berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Beranda()),
          );
        } else {
          // Tampilkan pesan gagal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Gagal mereset password. Pastikan email dan OTP benar.'),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else {
        // Handle jika request tidak berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Gagal melakukan koneksi ke server. Coba lagi nanti.'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Silakan coba lagi nanti.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF142B44),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/forgot_password');
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter OTP from email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter your new password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(200, 50),
                backgroundColor: Color(0xFF142B44),
              ),
              child: Text(
                'Reset Password',
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
    );
  }
}
