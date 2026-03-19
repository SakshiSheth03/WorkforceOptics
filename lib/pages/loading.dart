import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/models/my_controller.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:hrms_system/utils/input_controllers.dart';
import 'package:hrms_system/utils/current_user_info.dart';
import '../models/signInPageController.dart';
import '../utils/employee.dart';
import '../utils/leaves.dart';
import '../utils/tasks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hrms_system/models/auth.dart';

class Loading extends StatefulWidget {
  Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  MyController getXController = Get.put(MyController());
  SignInPageController signInPageController = Get.put(SignInPageController());

  String employeeId = '0';
  String usrEmail = InputControllers.signInEmailController.text;

  Future<void> fetchEmployees() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('employees').get();

      QuerySnapshot<Map<String, dynamic>> querySnapshotAdmin =
      await FirebaseFirestore.instance.collection('admin').get();

      MyController.empList.value = querySnapshot.docs
          .map((doc) => Employee.fromMap(doc.data()))
          .toList();

      MyController.admList.value = querySnapshotAdmin.docs
          .map((doc) => Employee.fromMap(doc.data()))
          .toList();

      bool check = checkUser();
      if(check) {
        bool pwdCheck = await signInWithEmailAndPassword();
        if (pwdCheck) {
          signInPageController.errorMessage.value = '';
          fetchLeaves();
        } else {
          signInPageController.errorMessage.value = '*Password does not match';
          Get.back();
        }
      } else {
        signInPageController.errorMessage.value = '*No such user exists';
        Get.back();
      }
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  bool checkUser() {
    String email = InputControllers.signInEmailController.text;
    if (signInPageController.selectedValue.value == 'Employee') {
      for (Employee employee in MyController.empList) {
        // Check if the employee's email matches the given email
        if (employee.empEmail == email) {
          return true; // Employee with the given email exists
        }
      }
      return false;
    } else {
      for (Employee employee in MyController.admList) {
        // Check if the employee's email matches the given email
        if (employee.empEmail == email) {
          return true; // Employee with the given email exists
        }
      }
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: InputControllers.signInEmailController.text, password: InputControllers.signInPasswordController.text);
      return true;
    } on FirebaseAuthException catch (e) {
      signInPageController.errorMessage.value = e.message!;
      return false;
    }
  }

  Future<void> fetchLeaves() async {
      try {
        QuerySnapshot querySnapshot1;
        if(signInPageController.selectedValue.value == 'Admin') {
          querySnapshot1 = await FirebaseFirestore.instance
              .collection('admin')
              .where('empEmail', isEqualTo: usrEmail)
              .limit(1) // Limiting to 1 document since email should be unique
              .get();
        } else {
          querySnapshot1 = await FirebaseFirestore.instance
              .collection('employees')
              .where('empEmail', isEqualTo: usrEmail)
              .limit(1) // Limiting to 1 document since email should be unique
              .get();
        }

        // if (querySnapshot1.docs.isNotEmpty) {
        employeeId = querySnapshot1.docs.first.id;
        // }
        QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
            await FirebaseFirestore.instance
                .collection('leaves')
                .doc(employeeId)
                .collection('leavesList')
                .get();

        getXController.leaves.value =
            querySnapshot2.docs.map((doc) => Leave.fromMap(doc.data())).toList();

        fetchTasks();
      } catch (e) {
        print('Error fetching leaves: $e');
      }
  }

  Future<void> fetchTasks() async {
    if(signInPageController.selectedValue.value == 'Admin') {
    } else {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(employeeId)
          .collection('tasksList')
          .get();

      getXController.tasks.value =
          querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();
    }
    assignUsrInfo();
  }

  void assignUsrInfo() async {
    try {
      Employee currentUserEmployee;
      if(signInPageController.selectedValue.value == 'Admin') {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('admin')
            .doc(employeeId)
            .get();
        if (snapshot.exists) {
          currentUserEmployee = Employee.fromMap(snapshot.data()!);
        } else {
          return null;
        }
      } else {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
            .collection('employees')
            .doc(employeeId)
            .get();
        if (snapshot.exists) {
          currentUserEmployee = Employee.fromMap(snapshot.data()!);
        } else {
          return null;
        }
      }
      CurrentUserInfo.empName.value = currentUserEmployee.empName;
      CurrentUserInfo.empID.value = currentUserEmployee.empID;
      CurrentUserInfo.empDOB.value = currentUserEmployee.empDOB;
      CurrentUserInfo.empEmail.value = currentUserEmployee.empEmail;
      CurrentUserInfo.empPhNum.value = currentUserEmployee.empPhNum;
      CurrentUserInfo.empBldGrp.value = currentUserEmployee.empBldGrp;
      CurrentUserInfo.empAdd.value = currentUserEmployee.empAdd;
      CurrentUserInfo.empNationality.value = currentUserEmployee.empNationality;
      CurrentUserInfo.empLang.value = currentUserEmployee.empLang;
      CurrentUserInfo.empJobTitle.value = currentUserEmployee.empJobTitle;
      CurrentUserInfo.empDept.value = currentUserEmployee.empDept;
      CurrentUserInfo.empStartDate.value = currentUserEmployee.empStartDate;
      CurrentUserInfo.empStatus.value = currentUserEmployee.empStatus;
      CurrentUserInfo.empPerformanceRatings.value = currentUserEmployee.empPerformanceRatings;
      CurrentUserInfo.empAchievements.value = currentUserEmployee.empAchievements;
      CurrentUserInfo.role.value = signInPageController.selectedValue.value;

      DocumentSnapshot<Map<String, dynamic>> profileImageSnapshot =
      await FirebaseFirestore.instance
          .collection('profileImages')
          .doc(employeeId)
          .get();
      if(profileImageSnapshot.exists) {
        CurrentUserInfo.profileImageUrl.value = profileImageSnapshot.data()!['imgUrl'];
      } else {
        CurrentUserInfo.profileImageUrl.value = 'https://firebasestorage.googleapis.com/v0/b/hrmsystem-6a062.appspot.com/o/images%2FprofileImageDefault.png?alt=media&token=7a43fc33-4feb-4b8a-a4fd-5e58ca2eb089';
      }

      navigateToDashboard();
    }
    catch (e) {
      print("Error message: $e");
    }
  }

  void navigateToDashboard() {
    InputControllers.signInEmailController.clear();
    InputControllers.signInPasswordController.clear();
    Get.offNamed('/dashboard');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: SpinKitCircle(
            color: AppColor.blue900,
            size: 70.0,
          ),
        ),
      ),
    );
  }
}
