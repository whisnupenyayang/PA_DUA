import 'package:flutter/material.dart';

class ResepKopiPage extends StatelessWidget {
  const ResepKopiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Kopi'),
      ),
      body: Center(
        child: Text('Temukan berbagai resep kopi di sini!'),
      ),
    );
  }
}
