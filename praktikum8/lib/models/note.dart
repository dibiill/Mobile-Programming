class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    // `createdAt` in the database may be stored as a TEXT (ISO string)
    // or as an integer timestamp. Handle both.
    final dynamic created = map['createdAt'];
    DateTime parsedCreated;
    if (created == null) {
      parsedCreated = DateTime.now();
    } else if (created is int) {
      parsedCreated = DateTime.fromMillisecondsSinceEpoch(created);
    } else {
      parsedCreated = DateTime.parse(created as String);
    }

    return Note(
      id: map['id'] == null ? null : (map['id'] as int),
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: parsedCreated,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
