import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:get/get.dart';
import '../models/my_controller.dart';
import '../utils/current_user_info.dart';
import '../utils/tasks.dart';

MyController getXController = Get.put(MyController());

class TasksPage extends StatelessWidget {

  TasksPage({super.key});

  String? empID = Get.arguments != null && Get.arguments.containsKey('empID') ? Get.arguments['empID'] : null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.blue900,
          toolbarHeight: 65.0,
          title: Text(
            'Tasks List',
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.white, // Tab Bar color change
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.grey300,
                            spreadRadius: 0.0,
                            blurRadius: 4.0,
                            offset: Offset(0,1),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(top: 4.0),
                      child: TabBar(
                        labelColor: AppColor.black,
                        unselectedLabelColor: AppColor.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: AppColor.blue900,
                        labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                        unselectedLabelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                        dividerColor: Colors.transparent,
                        indicator: UnderlineTabIndicator(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: AppColor.blue900,
                            width: 2.7,
                          ),
                        ),
                        tabs: [
                          Tab(
                            child: Align(alignment: Alignment.center,child: Text('All')),
                          ),
                          Tab(
                            child: Align(alignment: Alignment.center,child: Text('Pending')),
                          ),
                          Tab(
                            child: Align(alignment: Alignment.center,child: Text('Completed')),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Expanded(
                      flex: 3,
                      child: TabBarView(
                        children: [
                          Obx(() => ListViewBuilder(getXController.tasks.value, '')),
                          Obx(() => ListViewBuilder(getXController.tasks.value.where((task) => task.status == 'Pending').toList(), ' pending')),
                          Obx(() => ListViewBuilder(getXController.tasks.value.where((task) => task.status == 'Completed').toList(), ' completed')),
                        ],
                      ),
                    ),
                    CurrentUserInfo.role.value == 'Employee' ? SizedBox(height: 0.0,) : ElevatedButtonWidget(
                        context: context, buttonText: 'Assign Task', empID: empID!),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

Widget ListViewBuilder(List taskList, String type) {
  return taskList.length == 0 ? Center(
      child: Text('No tasks$type!'),
    )
    : ListView.builder(
        shrinkWrap: true,
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              if(CurrentUserInfo.role.value == 'Employee' && taskList[index].status != 'Pending') {
                Get.dialog(
                  Dialog(
                    child: GestureDetector(
                      onTap: () async{
                        Get.back();
                        Get.snackbar(
                          "Changed status to Pending!",
                          "Now when you complete the task, hit the completed button again.",
                          colorText: AppColor.black,
                          backgroundColor: AppColor.blue100,
                          icon: Icon(Icons.task_alt),
                          duration: Duration(seconds: 4),
                        );
                        try {
                          final empID = CurrentUserInfo.empID.value;
                          final taskID = "${(taskList[index].assignedOn.day).toString().padLeft(2, "0")}${(taskList[index].assignedOn.month).toString().padLeft(2, "0")}${(taskList[index].assignedOn.year).toString()}${(taskList[index].assignedOn.hour).toString().padLeft(2, "0")}${(taskList[index].assignedOn.minute).toString().padLeft(2, "0")}${(taskList[index].assignedOn.second).toString().padLeft(2, "0")}";
                          // Update the status of the leave to 'approved' in Firestore
                          await FirebaseFirestore.instance
                              .collection('tasks')
                              .doc('$empID') // Assuming employeeId is available
                              .collection('tasksList')
                              .doc(taskID) // Provide document ID of the leave document here
                              .update({'status': 'Pending'});

                          QuerySnapshot<Map<String, dynamic>> querySnapshot =
                          await FirebaseFirestore.instance
                              .collection('tasks')
                              .doc('$empID')
                              .collection('tasksList')
                              .get();
                          getXController.tasks.value =
                              querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();
                        } catch (e) {
                          print("Error changing status: $e");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(25.0),
                        height: 100.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Modify Status of task:'),
                            Text('${taskList[index].title}',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              if(CurrentUserInfo.role.value == 'Admin') {
                Get.dialog(
                  Dialog(
                    child: GestureDetector(
                      onTap: () async{
                        Get.back();
                        Get.snackbar(
                          "Task deleted successfully!",
                          "Now you need to reassign the task if you want it to be retrieved.",
                          colorText: AppColor.black,
                          backgroundColor: AppColor.blue100,
                          icon: Icon(Icons.delete),
                          duration: Duration(seconds: 4),
                        );
                        try {
                          final empID = Get.arguments['empID'];
                          final taskID = "${(taskList[index].assignedOn.day).toString().padLeft(2, "0")}${(taskList[index].assignedOn.month).toString().padLeft(2, "0")}${(taskList[index].assignedOn.year).toString()}${(taskList[index].assignedOn.hour).toString().padLeft(2, "0")}${(taskList[index].assignedOn.minute).toString().padLeft(2, "0")}${(taskList[index].assignedOn.second).toString().padLeft(2, "0")}";
                          // Update the status of the leave to 'approved' in Firestore
                          await FirebaseFirestore.instance
                              .collection('tasks')
                              .doc('$empID') // Assuming employeeId is available
                              .collection('tasksList')
                              .doc(taskID) // Provide document ID of the leave document here
                              .delete();

                          QuerySnapshot<Map<String, dynamic>> querySnapshot =
                          await FirebaseFirestore.instance
                              .collection('tasks')
                              .doc('$empID')
                              .collection('tasksList')
                              .get();
                          getXController.tasks.value =
                              querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();
                        } catch (e) {
                          print("Error changing status: $e");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(25.0),
                        height: 100.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Permanently delete the task:'),
                            Text('${taskList[index].title}',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 12.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
              color: AppColor.blue50,
              borderRadius: BorderRadius.circular(20.0),
              ),
              // height: 100.0,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${taskList[index].title}",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            // Text("For: ${leaveList[index].noOfDays} Days"),
                            Text("Assigned On: ${taskList[index].assignedOn.day}/${taskList[index].assignedOn.month}/${taskList[index].assignedOn.year}\nTime: ${taskList[index].assignedOn.hour}:${taskList[index].assignedOn.minute}"),
                            Text("Deadline: ${taskList[index].deadline.day}/${taskList[index].deadline.month}/${taskList[index].deadline.year}\nTime: ${taskList[index].assignedOn.hour}:${taskList[index].assignedOn.minute}"),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        padding: EdgeInsets.all(6.0),
                        // margin: EdgeInsets.all(3.0),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              taskList[index].status == 'Pending'
                                  ? Icons.timelapse
                                  : Icons.check_circle_outline,
                              size: 18.0,
                              color: taskList[index].status == 'Pending'
                                  ? Colors.grey.shade700
                                  : Colors.green,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("${taskList[index].status}",
                              style: TextStyle(
                                color: taskList[index].status == 'Pending'
                                    ? Colors.grey.shade700
                                    : Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Description : ${taskList[index].description}"),
                  CurrentUserInfo.role.value == 'Admin' ? SizedBox(height: 0.0,)
                      : taskList[index].status == 'Pending'
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            final empID = CurrentUserInfo.empID.value;
                            final taskID = "${(taskList[index].assignedOn.day).toString().padLeft(2, "0")}${(taskList[index].assignedOn.month).toString().padLeft(2, "0")}${(taskList[index].assignedOn.year).toString()}${(taskList[index].assignedOn.hour).toString().padLeft(2, "0")}${(taskList[index].assignedOn.minute).toString().padLeft(2, "0")}${(taskList[index].assignedOn.second).toString().padLeft(2, "0")}";
                            // Update the status of the leave to 'approved' in Firestore
                            await FirebaseFirestore.instance
                                .collection('tasks')
                                .doc('$empID') // Assuming employeeId is available
                                .collection('tasksList')
                                .doc(taskID) // Provide document ID of the leave document here
                                .update({'status': 'Completed'});

                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                            await FirebaseFirestore.instance
                                .collection('tasks')
                                .doc('$empID')
                                .collection('tasksList')
                                .get();
                            getXController.tasks.value =
                                querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();
                            Get.snackbar(
                              "Task Completed!",
                              "Congratulations on completing one more task.",
                              colorText: AppColor.black,
                              backgroundColor: AppColor.blue100,
                              icon: Icon(Icons.task_alt),
                              duration: Duration(seconds: 3),
                            );
                          } catch (e) {
                            print("Error changing status: $e");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          margin: EdgeInsets.only(top: 10.0),
                          padding: EdgeInsets.all(13),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                                size: 18.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                      : SizedBox(
                    height: 0.0,
                  ),
                ],
              ),
            ),
          );
        },
      );
}

Widget ElevatedButtonWidget({required context, required String buttonText, required String empID}) {
  return ElevatedButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.of(context).size.width * 0.9, 50.0)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
    onPressed: () async {
      try {
        Get.toNamed('/assignTaskPage', arguments: {'empID': empID});
        // if(check) {
        //
        // }
      } catch (e) {
        print('$e');
      }
    },
    child: Text(
      buttonText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
    ),
  );
}
