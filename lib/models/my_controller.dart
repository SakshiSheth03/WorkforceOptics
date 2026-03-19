import 'package:get/get.dart';

import '../utils/employee.dart';

class MyController extends GetxController{

  // List of employees
  static RxList<dynamic> empList = [].obs;

  static RxList<dynamic> admList = [].obs;

  // List of requested leaves of a particular employee
  final leaves = [].obs;

  // List of tasks assigned to a particular employee
  final tasks = [].obs;

  List<dynamic> getBirthdaysByMonth(int month) {
    return empList.where((employee) => employee.empDOB.month == month).toList();
  }

  // hard code check in time
  // hard code check out time

  // work report (additional functionality) add at last

  // Profile image of a particular user

  @override
  void onInit(){
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady(){
    // Get called after widget is rendered on the screen
    super.onReady();
  }

  @override
  void onClose(){
    //Get called when controller is removed from memory
    super.onClose();
  }
}