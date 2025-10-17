import 'package:flutter/material.dart';
import 'hasil_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Halaman Formulir',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const FormMahasiswaPage(),
  );
}

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();
  final cHp = TextEditingController(); // Nomor HP

  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;
  String? jenisKelamin; // Jenis Kelamin

  String get tglLahirLabel => tglLahir == null
      ? 'Pilih Tanggal Lahir'
      : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';
  String get jamLabel => jamBimbingan == null
      ? 'Pilih Jam Bimbingan'
      : '${jamBimbingan!.hour}:${jamBimbingan!.minute.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    cNama.dispose();
    cNpm.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    cHp.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (res != null) setState(() => tglLahir = res);
  }

  Future<void> _pickTime() async {
    final res = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (res != null) setState(() => jamBimbingan = res);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate() ||
        tglLahir == null ||
        jamBimbingan == null ||
        jenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi semua data')),
      );
      return;
    }

    final mahasiswa = Mahasiswa(
      nama: cNama.text.trim(),
      npm: cNpm.text.trim(),
      email: cEmail.text.trim(),
      nomorHp: cHp.text.trim(),
      alamat: cAlamat.text.trim(),
      jenisKelamin: jenisKelamin!,
      tanggalLahir: tglLahir!,
      jamBimbingan: jamBimbingan!,
    );

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => HasilPage(mahasiswa: mahasiswa)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Formulir Mahasiswa')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: 'Nama',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Nama wajib diisi' : null,
            ),
            TextFormField(
              controller: cNpm,
              decoration: const InputDecoration(
                labelText: 'NPM',
                prefixIcon: Icon(Icons.badge),
              ),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'NPM wajib diisi' : null,
            ),
            TextFormField(
              controller: cEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email wajib diisi';
                final ok = RegExp(r'^[^@]+@unsika\.ac\.id$').hasMatch(v.trim());
                return ok ? null : 'Email harus domain @unsika.ac.id';
              },
            ),
            TextFormField(
              controller: cHp,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Nomor HP wajib diisi';
                final onlyDigits = RegExp(r'^\d+$').hasMatch(value);
                if (!onlyDigits) return 'Nomor HP hanya boleh angka';
                if (value.length < 10) return 'Nomor HP minimal 10 digit';
                return null;
              },
            ),
            TextFormField(
              controller: cAlamat,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                prefixIcon: Icon(Icons.home),
              ),
              maxLines: 3,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Alamat wajib diisi' : null,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Jenis Kelamin',
                prefixIcon: Icon(Icons.wc),
              ),
              value: jenisKelamin,
              items: const [
                DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
              ],
              onChanged: (value) => setState(() => jenisKelamin = value),
              validator: (value) =>
                  value == null ? 'Jenis kelamin wajib dipilih' : null,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(tglLahirLabel),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ListTile(
              title: Text(jamLabel),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    ),
  );
}
