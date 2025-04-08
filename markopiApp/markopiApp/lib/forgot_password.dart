import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'connection.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = false;
  bool autoValidate = false;

  void validateEmail(String email) {
    if (email.isNotEmpty && email.toLowerCase().contains('@gmail.com')) {
      setState(() {
        isEmailValid = true;
      });
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  Future<void> _forgotPassword() async {
    final String apiUrl = Connection.buildUrl('/password/forgot');

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': emailController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        bool success = responseData['success'] ?? false;

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email untuk reset password telah dikirim.'),
              duration: Duration(seconds: 5),
            ),
          );

          // Navigasi ke halaman reset password setelah email berhasil dikirim
          Navigator.pushNamed(context, '/reset_password');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Gagal mengirim email reset password. Coba lagi nanti.'),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else {
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
          'Lupa Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF142B44),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
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
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isEmailValid ? Colors.green : Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 93, 93, 93),
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                validateEmail(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email cannot be empty';
                } else if (!value.toLowerCase().contains('@gmail.com')) {
                  return 'Please enter a valid Gmail address';
                }
                return null;
              },
              autovalidateMode: autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: isEmailValid ? _forgotPassword : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(150, 50),
                backgroundColor: isEmailValid
                    ? Color(0xFF142B44)
                    : Colors
                        .grey, // Ganti warna latar belakang berdasarkan validasi email
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Send Reset Email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ubah warna teks menjadi putih
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
