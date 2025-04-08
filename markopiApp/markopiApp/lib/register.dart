// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _fullNameController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _birthDateController = TextEditingController();
//   String? _gender;
//   String? _selectedProvince;
//   // String? _selectedDistrict;
//   List<String> _provinces = [];
//   // Map<String, List<String>> _districts = {};

//   @override
//   void initState() {
//     super.initState();
//     _fetchProvinces();
//   }

//   Future<void> _fetchProvinces() async {
//     final response = await http.get(Uri.parse(
//         'https://emsifa.github.io/api-wilayah-indonesia/api/provinces.json'));
//     final List<dynamic> data = json.decode(response.body);
//     List<String> provinces = [];
//     for (var province in data) {
//       provinces.add(province['name']); // Ubah sesuai dengan struktur data API
//     }
//     setState(() {
//       _provinces = provinces;
//     });
//   }

//   // Future<void> _fetchDistricts(String provinceId) async {
//   //   final response = await http.get(Uri.parse(
//   //       'https://emsifa.github.io/api-wilayah-indonesia/api/regencies/$provinceId.json'));

//   //   if (response.statusCode == 200) {
//   //     final List<dynamic> data = json.decode(response.body);
//   //     List<String> districts = [];
//   //     for (var district in data) {
//   //       districts.add(district[
//   //           'name']); // Sesuaikan dengan atribut yang berisi nama kabupaten/kota
//   //     }
//   //     setState(() {
//   //       _districts[provinceId] = districts;
//   //     });
//   //   } else {
//   //     throw Exception('Failed to load districts');
//   //   }
//   // }

//   Future<bool> _register() async {
//     String apiUrl =
//         'http://192.168.43.233:8000/api/register'; // Ganti dengan URL API Anda

//     Map<String, dynamic> data = {
//       'nama_lengkap': _fullNameController.text,
//       'username': _usernameController.text,
//       'tanggal_lahir': _birthDateController.text,
//       'jenis_kelamin': _gender,
//       'provinsi': _selectedProvince,
//       // 'kabupaten': _selectedDistrict,
//     };

//     try {
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: jsonEncode(data),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 201) {
//         return true; // Registrasi berhasil
//       } else {
//         return false; // Registrasi gagal
//       }
//     } catch (e) {
//       print('Error: $e');
//       return false; // Registrasi gagal karena terjadi kesalahan
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registrasi'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: TextFormField(
//                   controller: _fullNameController,
//                   decoration: InputDecoration(
//                     labelText: 'Nama Lengkap',
//                     border: InputBorder.none,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Mohon isi nama lengkap';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 padding: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Color.fromARGB(255, 160, 160, 162)),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: TextFormField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'Username',
//                     border: InputBorder.none,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Mohon isi username';
//                     }
//                     return null;
//                   },
//                 ),
//               ),

//               SizedBox(height: 10),
//               Text('Tanggal Lahir'),
//               GestureDetector(
//                 onTap: () async {
//                   final selectedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime.now(),
//                   );
//                   if (selectedDate != null) {
//                     setState(() {
//                       _birthDateController.text =
//                           "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
//                     });
//                   }
//                 },
//                 child: AbsorbPointer(
//                   child: Container(
//                     padding: EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       border:
//                           Border.all(color: Color.fromARGB(255, 160, 160, 161)),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: TextFormField(
//                       controller: _birthDateController,
//                       decoration: InputDecoration(
//                         labelText: '*DD-MM-YYYY',
//                         border: InputBorder.none,
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Mohon isi tanggal lahir';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 10),
//               Text('Jenis Kelamin'),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(5.0),
//                           bottomLeft: Radius.circular(5.0),
//                         ),
//                       ),
//                       child: RadioListTile<String>(
//                         title: Text('Laki-laki'),
//                         value: 'L',
//                         groupValue: _gender,
//                         onChanged: (value) {
//                           setState(() {
//                             _gender = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(5.0),
//                           bottomRight: Radius.circular(5.0),
//                         ),
//                       ),
//                       child: RadioListTile<String>(
//                         title: Text('Perempuan'),
//                         value: 'P',
//                         groupValue: _gender,
//                         onChanged: (value) {
//                           setState(() {
//                             _gender = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Text('Provinsi'),
//               DropdownButtonFormField<String>(
//                 value: _selectedProvince,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedProvince = value;
//                     // _selectedDistrict = null;
//                     try {
//                       // _fetchDistricts(value!);
//                     } catch (e) {
//                       // Menangani pengecualian di sini
//                       // print('Failed to load districts: $e');
//                       // Atau tambahkan logika lain sesuai kebutuhan Anda
//                     }
//                   });
//                 },
//                 items: _provinces.map((String province) {
//                   return DropdownMenuItem<String>(
//                     value: province,
//                     child: Text(province),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Pilih Provinsi',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Mohon pilih provinsi';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               Text('Kabupaten/Kota'),
//               // DropdownButtonFormField<String>(
//               //   value: _selectedDistrict,
//               //   onChanged: (value) {
//               //     setState(() {
//               //       _selectedDistrict = value;
//               //     });
//               //   },
//               //   items: _selectedProvince != null &&
//               //           _districts[_selectedProvince!] != null
//               //       ? _districts[_selectedProvince!]!.map((String district) {
//               //           return DropdownMenuItem<String>(
//               //             value: district,
//               //             child: Text(district),
//               //           );
//               //         }).toList()
//               //       : [],
//               //   decoration: InputDecoration(
//               //     border: OutlineInputBorder(),
//               //     hintText: 'Pilih Kabupaten/Kota',
//               //   ),
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Mohon pilih kabupaten/kota';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               // SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     // Validasi berhasil, lanjutkan proses registrasi
//                     bool success = await _register();
//                     if (success) {
//                       // Buat objek DateTime dari input tanggal lahir yang dipilih
//                       DateTime selectedBirthDate =
//                           DateTime.parse(_birthDateController.text);

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AdditionalDetailsScreen(
//                             userName: _usernameController.text,
//                             fullName: _fullNameController.text,
//                             birthDate:
//                                 selectedBirthDate, // Gunakan objek DateTime yang sudah dibuat
//                             gender: _gender!,
//                             province: _selectedProvince!,
//                             // district: _selectedDistrict!,
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Tampilkan pesan kesalahan jika registrasi gagal
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text('Registrasi gagal. Silakan coba lagi.'),
//                       ));
//                     }
//                   }
//                 },
//                 child: Text('Daftar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AdditionalDetailsScreen extends StatelessWidget {
//   final String fullName;
//   final String userName;
//   final DateTime birthDate;
//   final String gender;
//   final String province;
//   // final String district;

//   const AdditionalDetailsScreen({
//     required this.fullName,
//     required this.userName,
//     required this.birthDate,
//     required this.gender,
//     required this.province,
//     // required this.district,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Registrasi'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Nama Lengkap: $fullName'),
//             Text('Nama Lengkap: $userName'),
//             Text('Tanggal Lahir: $birthDate'),
//             Text('Jenis Kelamin: ${gender == 'L' ? 'Laki-laki' : 'Perempuan'}'),
//             Text('Provinsi: $province'),
//             // Text('Kabupaten: $district'),
//           ],
//         ),
//       ),
//     );
//   }
// }
