import 'package:flutter/material.dart';

class CompletedPage extends StatelessWidget {
  final List<Map<String, String>> completedEvents;

  const CompletedPage({super.key, required this.completedEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event yang Telah Selesai'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black87,
      ),
      body: completedEvents.isEmpty
          ? const Center(
              child: Text(
                'Belum ada event yang selesai',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: completedEvents.length,
              itemBuilder: (context, index) {
                final event = completedEvents[index];
                return Card(
                  color: Colors.green[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(
                      event['nama'] ?? 'Tanpa Judul',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instansi: ${event['instansi'] ?? '-'}'),
                          Text('Tempat: ${event['tempat'] ?? '-'}'),
                          Text('Tanggal: ${event['tanggal'] ?? '-'}'),
                          const SizedBox(height: 4),
                          Text('Deskripsi: ${event['deskripsi'] ?? '-'}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}