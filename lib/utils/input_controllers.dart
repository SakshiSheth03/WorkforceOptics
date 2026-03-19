import 'package:flutter/cupertino.dart';

class InputControllers{

  // SignIn page controllers
  static TextEditingController signInEmailController = TextEditingController();
  static TextEditingController signInPasswordController = TextEditingController();


  // Add Employee Controllers
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController contactNumController = TextEditingController();
  static TextEditingController birthDateController = TextEditingController();
  static TextEditingController bloodGroupController = TextEditingController();
  static TextEditingController nationalityController = TextEditingController();
  static TextEditingController languagesController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController jobTitleController = TextEditingController();
  static TextEditingController employmentStatusController = TextEditingController();
  static TextEditingController joiningDateController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();

  static void clearAllAddEmpControllers() {
    // Iterate over all the controllers and clear each one
    [
      nameController,
      emailController,
      contactNumController,
      birthDateController,
      bloodGroupController,
      nationalityController,
      languagesController,
      addressController,
      jobTitleController,
      employmentStatusController,
      joiningDateController,
      departmentController,
    ].forEach((controller) => controller.clear());
  }

  // Request Leave Controllers
  static TextEditingController typeOfLeaveController = TextEditingController();
  static TextEditingController noOfLeavesController = TextEditingController();
  static TextEditingController leaveFromDateController = TextEditingController();
  static TextEditingController leaveToDateController = TextEditingController();
  static TextEditingController leaveDescriptionController = TextEditingController();

  static void clearAllRequestLeaveControllers() {
    // Iterate over all the controllers and clear each one
    [
      typeOfLeaveController,
      noOfLeavesController,
      leaveFromDateController,
      leaveToDateController,
      leaveDescriptionController,
    ].forEach((controller) => controller.clear());
  }

  // Assign Task Controllers
  static TextEditingController taskTitleController = TextEditingController();
  static TextEditingController taskDescriptionController = TextEditingController();
  static TextEditingController taskDeadlineController = TextEditingController();

  static void clearAllAssignTaskControllers() {
    // Iterate over all the controllers and clear each one
    [
      taskTitleController,
      taskDescriptionController,
      taskDeadlineController,
    ].forEach((controller) => controller.clear());
  }
}