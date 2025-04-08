import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/connection.dart';

class UpdateProfilePage extends StatefulWidget {
  final String userId;

  const UpdateProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _gender;
  List<String> _genderOptions = ['Laki-laki', 'Perempuan'];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final response = await http.get(
      Uri.parse('${Connection.apiUrl}/getUserById/${widget.userId}'),
    );

    if (mounted) {
      // Tambahkan pengecekan ini sebelum memanggil setState
      if (response.statusCode == 200) {
        final Map<String, dynamic> userData =
            json.decode(response.body)['data'];
        setState(() {
          _fullNameController.text = userData['nama_lengkap'];
          _usernameController.text = userData['username'];
          _birthDateController.text = userData['tanggal_lahir'];
          _gender = userData['jenis_kelamin'];
          _phoneNumberController.text = userData['no_telp'];
        });
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    }
  }

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final Map<String, dynamic> userData = {
        'nama_lengkap': _fullNameController.text,
        'username': _usernameController.text,
        'tanggal_lahir': _birthDateController.text,
        'jenis_kelamin': _gender,
        'no_telp': _phoneNumberController.text,
      };

      try {
        final response = await http.put(
          Uri.parse('${Connection.apiUrl}/userUpdate/${widget.userId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userData),
        );

        if (response.statusCode == 200) {
          // Handle successful update
          print('Profile updated successfully');

          // Refresh data here
          _fetchUserData();

          // Navigate back with success status
          Navigator.pop(context, true);
        } else {
          // Handle error
          print('Failed to update profile: ${response.statusCode}');
        }
      } catch (e) {
        // Handle error
        print('Error updating profile: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Nama Lengkap';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          labelText: 'Username', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _birthDateController,
                      decoration: InputDecoration(
                        labelText: 'Birth Date',
                        border: OutlineInputBorder(),
                      ),
                      readOnly:
                          true, // Membuat field tidak bisa diedit langsung
                      onTap: () async {
                        // Tampilkan datepicker saat field diklik
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), // Tanggal saat ini
                          firstDate: DateTime(
                              1900), // Tanggal paling awal yang diperbolehkan
                          lastDate: DateTime
                              .now(), // Tanggal paling terakhir yang diperbolehkan
                          initialDatePickerMode:
                              DatePickerMode.day, // Hanya tampilkan tanggal
                        );

                        // Jika pengguna memilih tanggal, update nilai pada controller
                        if (pickedDate != null) {
                          setState(() {
                            _birthDateController.text =
                                pickedDate.toString().split(' ')[0];
                            // Memperbarui nilai controller dengan tanggal tanpa waktu
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your birth date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _gender,
                      items: _genderOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Gender', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih Jenis Kelamin';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Nomor Telepon';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double
                          .infinity, // Membuat tombol menyesuaikan lebar parent
                      child: ElevatedButton(
                        onPressed: _updateUserProfile,
                        child: Text('Update',
                            style: TextStyle(
                                color: Colors.white)), // Warna teks putih
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFF142B44), // Warna latar belakang tombol
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
