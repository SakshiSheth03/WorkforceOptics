import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/models/my_controller.dart';
import 'package:hrms_system/utils/current_user_info.dart';

import '../utils/app_colors.dart';
import '../utils/leaves.dart';

MyController getXController = Get.put(MyController());

class LeavePage extends StatelessWidget {
  LeavePage({super.key});

  bool isLoading = false;

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
            'Leaves List',
          ),
        ),
        body: !isLoading ? DefaultTabController(
                length: 4,
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
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(top: 4.0),
                      child: TabBar(
                        labelColor: AppColor.black,
                        unselectedLabelColor: AppColor.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: AppColor.blue900,
                        labelStyle: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
                        unselectedLabelStyle: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
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
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('All')),
                          ),
                          Tab(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Pending')),
                          ),
                          Tab(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Approved')),
                          ),
                          Tab(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Rejected')),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: TabBarView(
                        children: [
                          Obx(() => ListViewBuilder(getXController.leaves.value, '')),
                          Obx(() => ListViewBuilder(getXController.leaves.value.where((leave) => leave.status == 'Pending').toList(), ' pending')),
                          Obx(() => ListViewBuilder(getXController.leaves.value.where((leave) => leave.status == 'Approved').toList(), ' approved')),
                          Obx(() => ListViewBuilder(getXController.leaves.value.where((leave) => leave.status == 'Rejected').toList(), ' rejected')),
                        ],
                      ),
                    ),
                    CurrentUserInfo.role.value == 'Employee' ? ElevatedButtonWidget(
                        context: context, buttonText: 'Request Leave') : SizedBox(height: 0.0,),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

Widget ListViewBuilder(List<dynamic> leaveList, String type) {
  return leaveList.length == 0 ? Center(
          child: Text('No leave requests$type!'),
        )
      : ListView.builder(
          shrinkWrap: true,
          itemCount: leaveList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                if(CurrentUserInfo.role.value == 'Employee') {
                  Get.dialog(
                    Dialog(
                      child: GestureDetector(
                        onTap: () async{
                          Get.back();
                          Get.snackbar(
                            "Leave request deleted successfully!",
                            "Now you need to request again for the leave, no option for retrieval.",
                            colorText: AppColor.black,
                            backgroundColor: AppColor.blue100,
                            icon: Icon(Icons.delete),
                            duration: Duration(seconds: 4),
                          );
                          try {
                            final empID = CurrentUserInfo.empID.value;
                            final leaveID = "${(leaveList[index].fromDate.day).toString().padLeft(2, "0")}${(leaveList[index].fromDate.month).toString().padLeft(2, "0")}${(leaveList[index].fromDate.year).toString()}";
                            // Update the status of the leave to 'approved' in Firestore
                            await FirebaseFirestore.instance
                                .collection('leaves')
                                .doc('$empID') // Assuming employeeId is available
                                .collection('leavesList')
                                .doc(leaveID) // Provide document ID of the leave document here
                                .delete();

                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                            await FirebaseFirestore.instance
                                .collection('leaves')
                                .doc('$empID')
                                .collection('leavesList')
                                .get();
                            getXController.leaves.value =
                                querySnapshot.docs.map((doc) => Leave.fromMap(doc.data())).toList();
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
                              Text('Permanently delete leave request:'),
                              Text('${leaveList[index].typeOfLeave}',
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
                if(CurrentUserInfo.role.value == 'Admin' && leaveList[index].status != 'Pending') {
                  Get.dialog(
                    Dialog(
                      child: GestureDetector(
                        onTap: () async{
                          Get.back();
                          Get.snackbar(
                            "Changed status to Pending!",
                            "Now you need to approve/reject the status of the leave request again.",
                            colorText: AppColor.black,
                            backgroundColor: AppColor.blue100,
                            icon: Icon(Icons.task_alt),
                            duration: Duration(seconds: 4),
                          );
                          try {
                            final empID = Get.arguments['empID'];
                            final leaveID = "${(leaveList[index].fromDate.day).toString().padLeft(2, "0")}${(leaveList[index].fromDate.month).toString().padLeft(2, "0")}${(leaveList[index].fromDate.year).toString()}";
                            // Update the status of the leave to 'approved' in Firestore
                            await FirebaseFirestore.instance
                                .collection('leaves')
                                .doc('$empID') // Assuming employeeId is available
                                .collection('leavesList')
                                .doc(leaveID) // Provide document ID of the leave document here
                                .update({'status': 'Pending'});

                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                            await FirebaseFirestore.instance
                                .collection('leaves')
                                .doc('$empID')
                                .collection('leavesList')
                                .get();
                            getXController.leaves.value =
                                querySnapshot.docs.map((doc) => Leave.fromMap(doc.data())).toList();
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
                              Text('Modify status of the leave request:'),
                              Text('${leaveList[index].typeOfLeave}',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${leaveList[index].typeOfLeave}",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            leaveList[index].noOfDays == 1 ? Text("For: ${leaveList[index].noOfDays} Day") : Text("For: ${leaveList[index].noOfDays} Days"),
                            Text("From Date: ${leaveList[index].fromDate.day}/${leaveList[index].fromDate.month}/${leaveList[index].fromDate.year}"),
                            Text("To Date: ${leaveList[index].toDate.day}/${leaveList[index].toDate.month}/${leaveList[index].toDate.year}"),
                          ],
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
                                leaveList[index].status == 'Pending'
                                    ? Icons.timelapse
                                    : leaveList[index].status == 'Approved'
                                    ? Icons.check_circle_outline
                                    : Icons.highlight_remove,
                                size: 18.0,
                                color: leaveList[index].status == 'Pending'
                                    ? Colors.grey.shade700
                                    : leaveList[index].status == 'Approved'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("${leaveList[index].status}",
                                style: TextStyle(
                                  color: leaveList[index].status == 'Pending'
                                      ? Colors.grey.shade700
                                      : leaveList[index].status == 'Approved'
                                      ? Colors.green
                                      : Colors.red,
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
                    Text("Description : ${leaveList[index].description}"),
                    CurrentUserInfo.role.value == 'Employee' ? SizedBox(height: 0.0,)
                        : leaveList[index].status == 'Pending'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final empID = Get.arguments['empID'];
                                    final leaveID = "${(leaveList[index].fromDate.day).toString().padLeft(2, "0")}${(leaveList[index].fromDate.month).toString().padLeft(2, "0")}${(leaveList[index].fromDate.year).toString()}";
                                    // Update the status of the leave to 'approved' in Firestore
                                    await FirebaseFirestore.instance
                                        .collection('leaves')
                                        .doc('$empID') // Assuming employeeId is available
                                        .collection('leavesList')
                                        .doc(leaveID) // Provide document ID of the leave document here
                                        .update({'status': 'Approved'});

                                    QuerySnapshot<Map<String, dynamic>> querySnapshot =
                                    await FirebaseFirestore.instance
                                        .collection('leaves')
                                        .doc('$empID')
                                        .collection('leavesList')
                                        .get();
                                    getXController.leaves.value =
                                        querySnapshot.docs.map((doc) => Leave.fromMap(doc.data())).toList();
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
                                        'Approve',
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
                              SizedBox(
                                width: 20.0,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final empID = Get.arguments['empID'];
                                    final leaveID = "${(leaveList[index].fromDate.day).toString().padLeft(2, "0")}${(leaveList[index].fromDate.month).toString().padLeft(2, "0")}${(leaveList[index].fromDate.year).toString()}";

                                    // Update the status of the leave to 'approved' in Firestore
                                    await FirebaseFirestore.instance
                                        .collection('leaves')
                                        .doc('$empID') // Assuming employeeId is available
                                        .collection('leavesList')
                                        .doc(leaveID) // Provide document ID of the leave document here
                                        .update({'status': 'Rejected'});

                                    QuerySnapshot<Map<String, dynamic>> querySnapshot =
                                    await FirebaseFirestore.instance
                                        .collection('leaves')
                                        .doc('$empID')
                                        .collection('leavesList')
                                        .get();
                                    getXController.leaves.value =
                                        querySnapshot.docs.map((doc) => Leave.fromMap(doc.data())).toList();
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
                                        Icons.highlight_remove,
                                        color: Colors.red,
                                        size: 18.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Reject',
                                        style: TextStyle(
                                          color: Colors.red,
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

Widget ElevatedButtonWidget({required context, required String buttonText}) {
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
        Get.toNamed('/requestLeavePage');
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
