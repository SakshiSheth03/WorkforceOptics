import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:hrms_system/utils/current_user_info.dart';
import 'package:hrms_system/utils/employee.dart';
import 'package:hrms_system/utils/input_controllers.dart';
import 'package:hrms_system/utils/leaves.dart';
import 'package:hrms_system/utils/tasks.dart';
import 'package:intl/intl.dart';
import '../models/my_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hrms_system/models/auth.dart';
import 'package:get/get.dart';

MyController getXController = Get.put(MyController());

class HelperMethods{

  static Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await Auth().createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  static Future<void> createNewEmployee() async{
    int deptNum;
    int empNum = MyController.empList.where((emp) => emp.empDept == InputControllers.departmentController.text).length + 1;
    switch (InputControllers.departmentController.text) {
      case 'Flutter': {
        deptNum = 1;
      } break;
      case 'ReactJS': {
        deptNum = 2;
      } break;
      case 'NodeJS': {
        deptNum = 3;
      } break;
      case 'Digital Marketing': {
        deptNum = 4;
      } break;
      case 'UI/UX': {
        deptNum = 5;
      } break;
      default: {
        deptNum = 0;
      } break;
    }
    String newID = "${InputControllers.joiningDateController.text.substring(8)}${deptNum.toString().padLeft(2, "0")}${empNum.toString().padLeft(2, "0")}";
    Employee newEmp = Employee(
        empName: InputControllers.nameController.text,
        empID: int.parse(newID),
        empDOB: DateFormat('dd-MM-yyyy').parse(InputControllers.birthDateController.text),
        empEmail: InputControllers.emailController.text,
        empBldGrp: InputControllers.bloodGroupController.text,
        empPhNum: int.parse(InputControllers.contactNumController.text),
        empNationality: InputControllers.nationalityController.text,
        empLang: InputControllers.languagesController.text,
        empAdd: InputControllers.addressController.text,
        empJobTitle: InputControllers.jobTitleController.text,
        empDept: InputControllers.departmentController.text,
        empStartDate: DateFormat('dd-MM-yyyy').parse(InputControllers.joiningDateController.text),
        empStatus: InputControllers.employmentStatusController.text,
        empPerformanceRatings: 0.0,
        empAchievements: ''
    );

    // Add employee to controller list
    MyController.empList.add(newEmp);

    // Add employee to firebase
    var collectionObj = FirebaseFirestore.instance.collection('employees');
    collectionObj.doc(newID).set(newEmp.toMap());

    // Generate automatic password
    Random random = Random();
    String usrAutoPwd = "${InputControllers.nameController.text.substring(0,3)}${newID.substring(2)}";

    // Add emp email/password to Auth
    await createUserWithEmailAndPassword(InputControllers.emailController.text, usrAutoPwd);

    Get.back();
    // Clear all the controllers
    InputControllers.clearAllAddEmpControllers();

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('employees').get();
    MyController.empList.value = querySnapshot.docs
        .map((doc) => Employee.fromMap(doc.data()))
        .toList();
  }

  static Future<void> requestLeave() async{
    Leave newLeave = Leave(
        typeOfLeave: InputControllers.typeOfLeaveController.text,
        noOfDays: int.parse(InputControllers.noOfLeavesController.text),
        fromDate: DateFormat('dd-MM-yyyy').parse(InputControllers.leaveFromDateController.text),
        toDate: DateFormat('dd-MM-yyyy').parse(InputControllers.leaveToDateController.text),
        description: InputControllers.leaveDescriptionController.text,
        status: 'Pending'
    );
    String leaveID = "${(newLeave.fromDate.day).toString().padLeft(2, "0")}${(newLeave.fromDate.month).toString().padLeft(2, "0")}${(newLeave.fromDate.year).toString()}";
    var collectionObj = FirebaseFirestore.instance.collection('leaves');
    collectionObj.doc('${CurrentUserInfo.empID}').collection('leavesList').doc(leaveID).set(newLeave.toMap());

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance
        .collection('leaves')
        .doc('${CurrentUserInfo.empID}')
        .collection('leavesList')
        .get();
    getXController.leaves.value =
        querySnapshot.docs.map((doc) => Leave.fromMap(doc.data())).toList();

    InputControllers.clearAllRequestLeaveControllers();
  }

  static Future<void> assignTask(String empID) async{
    Task newTask = Task(
        title: InputControllers.taskTitleController.text,
        description: InputControllers.taskDescriptionController.text,
        assignedOn: DateTime.now(),
        deadline: DateFormat('dd-MM-yyyy').parse(InputControllers.taskDeadlineController.text),
        status: 'Pending'
    );
    String taskID = "${(newTask.assignedOn.day).toString().padLeft(2, "0")}${(newTask.assignedOn.month).toString().padLeft(2, "0")}${(newTask.assignedOn.year).toString()}${(newTask.assignedOn.hour).toString().padLeft(2, "0")}${(newTask.assignedOn.minute).toString().padLeft(2, "0")}${(newTask.assignedOn.second).toString().padLeft(2, "0")}";
    var collectionObj = FirebaseFirestore.instance.collection('tasks');
    collectionObj.doc(empID).collection('tasksList').doc(taskID).set(newTask.toMap());

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(empID)
        .collection('tasksList')
        .get();
    getXController.tasks.value =
        querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();

    InputControllers.clearAllAssignTaskControllers();
  }

  static Future<void> changeProfileImage(String imgUrl) async {
    if(imgUrl.isEmpty) {
      Get.snackbar(
        "No image selected",
        "Please select an image to upload",
        colorText: AppColor.black,
        backgroundColor: AppColor.blue100,
        icon: Icon(Icons.add_a_photo),
      );
      return;
    }
    Map<String, String> data = { 'imgUrl' : imgUrl};
    var collectionObj = FirebaseFirestore.instance.collection('profileImages');
    collectionObj.doc('${CurrentUserInfo.empID}').set(data);
  }

  static Future<void> deleteProfileImageDoc() async {
    var collectionObj = FirebaseFirestore.instance.collection('profileImages');
    collectionObj.doc('${CurrentUserInfo.empID}').delete();
  }
}

