class Employee{
  final String empName;
  final int empID;
  final DateTime empDOB;
  String empEmail;
  int empPhNum;
  final String empBldGrp;
  String empAdd;
  String empNationality;
  String empLang;
  String empJobTitle;
  String empDept;
  DateTime empStartDate;
  String empStatus; //full-time, part-time
  double empPerformanceRatings;
  String empAchievements;
  
  Employee({
    required this.empName,
    required this.empID,
    required this.empDOB,
    required this.empEmail,
    required this.empBldGrp,
    required this.empPhNum,
    required this.empNationality,
    required this.empLang,
    required this.empAdd,
    required this.empJobTitle,
    required this.empDept,
    required this.empStartDate,
    required this.empStatus,
    required this.empPerformanceRatings,
    required this.empAchievements,
  });

  Map<String, dynamic> toMap() {
    return {
      'empName': empName,
      'empID': empID,
      'empDOB' : empDOB,
      'empEmail' : empEmail,
      'empBldGrp' : empBldGrp,
      'empPhNum' : empPhNum,
      'empNationality' : empNationality,
      'empLang' : empLang,
      'empAdd' : empAdd,
      'empJobTitle' : empJobTitle,
      'empDept' : empDept,
      'empStartDate' : empStartDate,
      'empStatus' : empStatus,
      'empPerformanceRatings' : empPerformanceRatings,
      'empAchievements' : empAchievements,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      empName: map['empName'],
      empID: map['empID'],
      empDOB: (map['empDOB']).toDate(),
      empEmail: map['empEmail'],
      empBldGrp: map['empBldGrp'],
      empPhNum: map['empPhNum'],
      empNationality: map['empNationality'],
      empLang: map['empLang'],
      empAdd: map['empAdd'],
      empJobTitle: map['empJobTitle'],
      empDept: map['empDept'],
      empStartDate: (map['empStartDate']).toDate(),
      empStatus: map['empStatus'],
      empPerformanceRatings: map['empPerformanceRatings'],
      empAchievements: map['empAchievements'],
    );
  }
}