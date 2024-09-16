class Todo {
  String id;
  String title;
  DateTime dateTime;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.isDone,
  });

  // Map'dan Todo obyektini yaratish
  factory Todo.fromMap(Map<String, dynamic> json) {
    // DATETIME ni String'dan DateTime ga aylantiramiz
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      dateTime: DateTime.parse(
          json['DATETIME'] as String), // DateTime.parse qo'shildi
      isDone: json['isDone'] as bool,
    );
  }

  // Todo obyektidan Map yaratish
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'DATETIME': dateTime
          .toIso8601String(), // DateTime ni String ga aylantirish (ISO formatda)
      'isDone': isDone,
    };
  }

  // JSON formatga aylantirish

}
