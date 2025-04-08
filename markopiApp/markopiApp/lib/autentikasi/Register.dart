import 'dart:convert';
import 'package:belajar_flutter/beranda.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:belajar_flutter/model/registeration_data.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _gender;
  String? _selectedProvince;
  String? _selectedProvinceId;
  String? _selectedDistrict;
  List<dynamic> _provinces = [];
  Map<String, List<String>> _districts = {};
  bool _autoValidatePhoneNumber = false;

  @override
  void initState() {
    super.initState();
    _fetchProvinces();
  }

  Future<void> _fetchProvinces() async {
    final response = await http.get(Uri.parse(
        'https://emsifa.github.io/api-wilayah-indonesia/api/provinces.json'));
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _provinces = data;
    });

    if (_provinces.isNotEmpty) {
      _selectedProvinceId = _provinces[0]['id'];
      _fetchDistricts(_selectedProvinceId!);
    }
  }

  Future<void> _fetchDistricts(String? provinceId) async {
    final response = await http.get(Uri.parse(
        'https://emsifa.github.io/api-wilayah-indonesia/api/regencies/${provinceId}.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<String> districts = [];
      for (var district in data) {
        districts.add(district['name']);
      }
      setState(() {
        _districts[provinceId!] = districts;
      });
    } else {
      print('Failed to load districts: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            color: Colors.white, // Warna teks di AppBar
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon isi nama lengkap';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon isi username';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon isi email anda';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    border: InputBorder.none,
                  ),
                  onChanged: (_) {
                    setState(() {
                      _autoValidatePhoneNumber =
                          true; // Ketika nomor telepon diubah, set autovalidate ke true
                    });
                  },
                  validator: (value) {
                    if (_autoValidatePhoneNumber) {
                      // Hanya lakukan validasi jika autovalidate diaktifkan
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi nomor telepon';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'anda memasukkan huruf, masukkan angka';
                      }
                      if (value.length < 11 || value.length > 13) {
                        return 'Nomor telepon harus terdiri dari 11-13 karakter';
                      }
                    }
                    return null;
                  },
                  autovalidateMode:
                      _autoValidatePhoneNumber // Set autovalidate hanya untuk nomor telepon
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                ),
              ),
              SizedBox(height: 10),
              Text('Tanggal Lahir'),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 160, 160, 161)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _birthDateController,
                  readOnly: true, // Set supaya tidak bisa diedit langsung
                  onTap: () async {
                    // Menampilkan dialog pemilih tanggal saat kotak teks ditekan
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        // Memperbarui nilai kotak teks dengan tanggal yang dipilih
                        _birthDateController.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon isi tanggal lahir';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Text('Jenis Kelamin'),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      ),
                      child: RadioListTile<String>(
                        title: Text('Laki-laki'),
                        value: 'Laki-laki',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                      ),
                      child: RadioListTile<String>(
                        title: Text('Perempuan'),
                        value: 'Perempuan',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text('Provinsi'),
              DropdownButtonFormField<String>(
                value: _selectedProvince,
                onChanged: (String? provinceName) {
                  setState(() {
                    _selectedProvince = provinceName;
                    _selectedProvinceId = _provinces != null
                        ? _provinces.firstWhere((province) =>
                            province['name'] == provinceName)['id']
                        : null;
                    _selectedDistrict = null;
                    if (_selectedProvinceId != null) {
                      _fetchDistricts(_selectedProvinceId!);
                    }
                  });
                },
                items: _provinces != null
                    ? _provinces
                        .map<DropdownMenuItem<String>>((dynamic province) {
                        return DropdownMenuItem<String>(
                          value: province['name'],
                          child: Text(province['name']),
                        );
                      }).toList()
                    : [],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Pilih Provinsi',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon pilih provinsi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text('Kabupaten/Kota'),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (String? district) {
                  setState(() {
                    _selectedDistrict = district;
                  });
                },
                items: _selectedProvinceId != null &&
                        _districts[_selectedProvinceId] != null
                    ? _districts[_selectedProvinceId]!.map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList()
                    : [],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Pilih Kabupaten/Kota',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon pilih kabupaten/kota';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF142B44), // Warna latar belakang
                  borderRadius: BorderRadius.circular(8), // Bentuk sudut tombol
                ),
                child: TextButton(
                  onPressed:
                      _handleDaftarButtonPressed, // Fungsi ketika tombol ditekan
                  child: Text(
                    'Selanjutnya',
                    style: TextStyle(
                      color: Colors.white, // Warna teks
                      fontSize: 16, // Ukuran teks
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleDaftarButtonPressed() {
    if (_formKey.currentState!.validate()) {
      if (_gender != null &&
          _selectedProvince != null &&
          _selectedDistrict != null) {
        // Tambahkan pengecekan untuk variabel yang bisa null
        RegistrationData registrationData = RegistrationData(
          fullName: _fullNameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          birthDate: _birthDateController.text,
          gender: _gender!,
          province: _selectedProvince!,
          district: _selectedDistrict!,
          password: '', // Password will be entered in the next screen
          phoneNumber: _phoneNumberController.text,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdditionalDetailsScreen(
              registrationData: registrationData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Mohon isi data dengan benar'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}

class AdditionalDetailsScreen extends StatefulWidget {
  final RegistrationData registrationData;

  const AdditionalDetailsScreen({Key? key, required this.registrationData})
      : super(key: key);

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText =
      true; // Untuk mengatur apakah password tersembunyi atau tidak

  bool _isPasswordValid(String password) {
    // Memeriksa panjang password
    if (password.length < 8) {
      return false;
    }
    // Memeriksa apakah password mengandung angka
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    // Memeriksa apakah password mengandung huruf
    bool hasLetters = password.contains(RegExp(r'[A-Za-z]'));

    return hasDigits && hasLetters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            color: Colors.white, // Warna teks di AppBar
          ),
        ),
        backgroundColor: Color(0xFF142B44),
        iconTheme:
            IconThemeData(color: Colors.white), // Mengatur warna panah putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(), // Menambahkan border di sini
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isPasswordValid(_passwordController.text)
                            ? Colors.green
                            : const Color.fromARGB(
                                255, 0, 0, 0)), // Warna border saat validasi
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Color.fromARGB(255, 90, 90, 90),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon isi password';
                  }
                  if (!_isPasswordValid(value)) {
                    if (value.length < 8) {
                      return 'Password harus minimal 8 karakter';
                    } else {
                      return 'Password harus terdiri dari angka dan huruf';
                    }
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
              SizedBox(height: 10), // Spacer
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: double.infinity, // Panjang tombol
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _handleRegisterButtonPressed();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF142B44), // Warna latar belakang tombol
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0), // Padding dalam tombol
                    ),
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.white, // Warna teks tombol
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRegisterButtonPressed() {
    RegistrationData registrationData = widget.registrationData;
    registrationData.password = _passwordController.text;

    _registerAccount(registrationData);
  }

  Future<void> _registerAccount(RegistrationData registrationData) async {
    final response = await http.post(
      Uri.parse('https://www.markopi.cloud/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nama_lengkap': registrationData.fullName,
        'username': registrationData.username,
        'password': registrationData.password,
        'email': registrationData.email,
        'tanggal_lahir': registrationData.birthDate,
        'jenis_kelamin': registrationData.gender,
        'provinsi': registrationData.province,
        'kabupaten': registrationData.district,
        'no_telp': registrationData.phoneNumber,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pendaftaran berhasil'),
        backgroundColor: Colors.green,
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Beranda()),
      );
    } else {
      print('Error during registration: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal mendaftar. Silakan coba lagi.'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
