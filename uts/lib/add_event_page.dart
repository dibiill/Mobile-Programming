import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _instansiController = TextEditingController();
  final TextEditingController _tempatController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  DateTime? _selectedDate;

  void _pilihTanggal() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _simpanEvent() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      Navigator.pop(context, {
        'nama': _namaController.text,
        'instansi': _instansiController.text,
        'tempat': _tempatController.text,
        'tanggal':
            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
        'deskripsi': _deskripsiController.text,
      });
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanggal terlebih dahulu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Event Baru'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black87,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Data Event',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Nama Event
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Event',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Nama event tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),

              // Instansi
              TextFormField(
                controller: _instansiController,
                decoration: const InputDecoration(
                  labelText: 'Instansi Penyelenggara',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Instansi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),

              // Tempat Kegiatan
              TextFormField(
                controller: _tempatController,
                decoration: const InputDecoration(
                  labelText: 'Tempat Kegiatan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Tempat kegiatan tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),

              // Deskripsi
              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Event',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),

              // Pilih Tanggal
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Belum memilih tanggal'
                          : 'Tanggal: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                  ),
                  Tooltip(
                    message: 'Pilih tanggal kegiatan',
                    child: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      color: Colors.blueAccent,
                      onPressed: _pilihTanggal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Simpan Event',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _simpanEvent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}