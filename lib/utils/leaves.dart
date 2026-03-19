class Leave{
  final String typeOfLeave;
  final int noOfDays;
  final DateTime fromDate;
  final DateTime toDate;
  final String description;
  String status;

  Leave({
    required this.typeOfLeave,
    required this.noOfDays,
    required this.fromDate,
    required this.toDate,
    required this.description,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'typeOfLeave' : typeOfLeave,
      'noOfDays' : noOfDays,
      'fromDate' : fromDate,
      'toDate' : toDate,
      'description' : description,
      'status' : status,
    };
  }

  factory Leave.fromMap(Map<String, dynamic> map) {
    return Leave(
      typeOfLeave: map['typeOfLeave'],
      noOfDays: map['noOfDays'],
      fromDate: (map['fromDate']).toDate(),
      toDate: (map['toDate']).toDate(),
      description: map['description'],
      status: map['status'],
    );
  }
}