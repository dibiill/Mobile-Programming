import 'package:flutter/material.dart';

class Hewan {
  String nama;
  double berat;

  Hewan(this.nama, this.berat);

  void makan(double porsi) {
    berat += porsi;
  }
}

class Kucing extends Hewan {
  String warnaBulu;
  Kucing(String nama, double berat, this.warnaBulu) : super(nama, berat);

  @override
  void makan(double porsi) {
    super.makan(porsi);
    print('Kucing $nama sedang makan sebanyak ${porsi.toStringAsFixed(2)} kg.');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum10',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Kucing kucing;

  @override
  void initState() {
    super.initState();
    kucing = Kucing('Luna', 4.0, 'Putih'); 
  }

  void _makan() {
    setState(() {
      kucing.makan(1.0); 
    });
  }

  void _lari() {
    setState(() {
      kucing.berat = (kucing.berat - 0.5) < 0
          ? 0
          : kucing.berat - 0.5; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kucing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nama: ${kucing.nama}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Warna Bulu: ${kucing.warnaBulu}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Berat: ${kucing.berat.toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _makan, child: const Text('Makan')),
                const SizedBox(width: 16),
                ElevatedButton(onPressed: _lari, child: const Text('Lari')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
