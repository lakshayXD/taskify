class Task {
  final int id;
   String title;
   bool isCompleted;

  Task({required this.id, required this.title, required this.isCompleted});

   Task copyWith({String? title, bool? isCompleted}) {
     return Task(
       id: id,
       title: title ?? this.title,
       isCompleted: isCompleted ?? this.isCompleted,
     );
   }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}