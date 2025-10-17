import 'package:flutter/material.dart';

class Mahasiswa {
  final String nama;
  final String npm;
  final String email;
  final String nomorHp;
  final String alamat;
  final String jenisKelamin;
  final DateTime tanggalLahir;
  final TimeOfDay jamBimbingan;

  Mahasiswa({
    required this.nama,
    required this.npm,
    required this.email,
    required this.nomorHp,
    required this.alamat,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.jamBimbingan,
  });
}

class HasilPage extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const HasilPage({super.key, required this.mahasiswa});

  String get tglLabel =>
      '${mahasiswa.tanggalLahir.day}/${mahasiswa.tanggalLahir.month}/${mahasiswa.tanggalLahir.year}';
  String get jamLabel =>
      '${mahasiswa.jamBimbingan.hour}:${mahasiswa.jamBimbingan.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Pengisian')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(title: const Text('Nama'), subtitle: Text(mahasiswa.nama)),
            ListTile(title: const Text('NPM'), subtitle: Text(mahasiswa.npm)),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(mahasiswa.email),
            ),
            ListTile(
              title: const Text('Nomor HP'),
              subtitle: Text(mahasiswa.nomorHp),
            ),
            ListTile(
              title: const Text('Alamat'),
              subtitle: Text(mahasiswa.alamat),
            ),
            ListTile(
              title: const Text('Jenis Kelamin'),
              subtitle: Text(mahasiswa.jenisKelamin),
            ),
            ListTile(
              title: const Text('Tanggal Lahir'),
              subtitle: Text(tglLabel),
            ),
            ListTile(
              title: const Text('Jam Bimbingan'),
              subtitle: Text(jamLabel),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}