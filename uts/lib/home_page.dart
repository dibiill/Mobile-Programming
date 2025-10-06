import 'package:flutter/material.dart';
import 'add_event_page.dart';
import 'completed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> events = [];
  final List<Map<String, String>> completedEvents = [];
  final Set<int> expandedIndexes =
      {}; // untuk melacak event yang deskripsinya terbuka

  void _addEvent(Map<String, String> newEvent) {
    setState(() {
      events.add(newEvent);
    });
  }

  void _completeEvent(int index) {
    setState(() {
      completedEvents.add(events[index]);
      events.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Event "${completedEvents.last['nama']}" telah ditandai selesai',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Event'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black87,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tambah Event'),
              onTap: () async {
                Navigator.pop(context);
                final newEvent = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddEventPage()),
                );
                if (newEvent != null && newEvent is Map<String, String>) {
                  _addEvent(newEvent);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Event Selesai'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CompletedPage(completedEvents: completedEvents),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: events.isEmpty
          ? const Center(child: Text('Belum ada event yang ditambahkan'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final isExpanded = expandedIndexes.contains(index);

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.event,
                            color: Color.fromARGB(255, 65, 169, 221),
                          ),
                          title: Text(
                            event['nama'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${event['instansi']} \n ${event['tanggal']} \n ${event['tempat']}',
                          ),
                          trailing: Tooltip(
                            message: 'Deskripsi Kegiatan',
                            child: IconButton(
                              icon: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isExpanded) {
                                    expandedIndexes.remove(index);
                                  } else {
                                    expandedIndexes.add(index);
                                  }
                                });
                              },
                            ),
                          ),
                        ),

                        if (isExpanded) ...[
                          const SizedBox(height: 6),
                          Text('Deskripsi: ${event['deskripsi'] ?? '-'}'),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Tooltip(
                              message: 'Tandai Event Telah Selesai',
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Tandai Selesai',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () => _completeEvent(index),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEvent = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEventPage()),
          );
          if (newEvent != null && newEvent is Map<String, String>) {
            _addEvent(newEvent);
          }
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
