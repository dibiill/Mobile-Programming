import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Kampus App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 233, 233, 233),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}