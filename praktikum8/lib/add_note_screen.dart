import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/note.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note; // if provided, screen will edit existing note

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final dbHelper = DatabaseHelper();

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      if (widget.note != null && widget.note!.id != null) {
        // update existing note
        final updated = Note(
          id: widget.note!.id,
          title: titleController.text,
          content: contentController.text,
          createdAt: widget.note!.createdAt,
        );
        await dbHelper.updateNote(updated);
      } else {
        // insert new
        final newNote = Note(
          title: titleController.text,
          content: contentController.text,
          createdAt: now,
        );
        await dbHelper.insertNote(newNote);
      }

      Navigator.pop(context, true); // return true to indicate change
    }
  }

  @override
  void initState() {
    super.initState();
    // If editing an existing note, prefill fields
    final n = widget.note;
    if (n != null) {
      titleController.text = n.title;
      contentController.text = n.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Tambah Catatan' : 'Edit Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) =>
                    value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Isi catatan'),
                maxLines: 5,
                validator: (value) =>
                    value!.isEmpty ? 'Isi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveNote, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
