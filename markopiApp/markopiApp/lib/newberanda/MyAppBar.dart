import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 88, // Sisa dari 120 - 32 agar tetap sesuai ukuran
      titleSpacing: 20,
      title: Row(
        children: [
          const Icon(Icons.account_circle, size: 85),
          const SizedBox(width: 15), // Jarak antara ikon dan teks
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Nama Pengguna",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Mari Jelajahi Yuk!",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 80,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFF2696D6), // Warna biru
              borderRadius: BorderRadius.circular(8), // Membuat sudut membulat
              boxShadow: [
                BoxShadow(
                  color: Colors.black26, // Warna bayangan
                  blurRadius: 4, // Seberapa blur bayangannya
                  offset: Offset(2, 2), // Posisi bayangan (kanan bawah)
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              'masuk',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 4,
      shadowColor: Colors.white,
    );
  }
}
