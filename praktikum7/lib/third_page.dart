import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Ketiga')),
      body: const Center(child: Text('Ini adalah Halaman Ketiga')),
    );
  }
}
