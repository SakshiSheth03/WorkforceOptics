class Task{
  String title;
  String description;
  DateTime assignedOn;
  DateTime deadline;
  String status;

  Task({
    required this.title,
    required this.description,
    required this.assignedOn,
    required this.deadline,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'title' : title,
      'description' : description,
      'assignedOn' : assignedOn,
      'deadline' : deadline,
      'status' : status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      assignedOn: (map['assignedOn']).toDate(),
      deadline: (map['deadline']).toDate(),
      status: map['status'],
    );
  }
}