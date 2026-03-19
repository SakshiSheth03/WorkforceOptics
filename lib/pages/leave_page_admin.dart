import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:get/get.dart';
import '../common_widgets/employee_info_dialog.dart';
import '../models/my_controller.dart';
import '../utils/leaves.dart';
import '../utils/tasks.dart';

MyController getXController = Get.put(MyController());

class LeavePageAdmin extends StatelessWidget {
  bool isLeavePage;
  LeavePageAdmin({
    super.key,
    required this.isLeavePage,
  });

  @override
  Widget build(BuildContext context) {

    final flutterEmps = MyController.empList.where((employee) => employee.empDept == 'Flutter').toList();
    final reactJSEmps = MyController.empList.where((employee) => employee.empDept == 'ReactJS').toList();
    final nodeJSEmps = MyController.empList.where((employee) => employee.empDept == 'NodeJS').toList();
    final uIUXEmps = MyController.empList.where((employee) => employee.empDept == 'UI/UX').toList();
    final digitalMarketingEmps = MyController.empList.where((employee) => employee.empDept == 'Digital Marketing').toList();

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.blue900,
            foregroundColor: AppColor.white,
            title: Text('Employees'),
            toolbarHeight: 65.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Flutter',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  ListViewBuilderWidget(flutterEmps, isLeavePage),
                  SizedBox(height: 10.0,),
                  Text('ReactJS',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  ListViewBuilderWidget(reactJSEmps, isLeavePage),
                  SizedBox(height: 10.0,),
                  Text('NodeJS',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  ListViewBuilderWidget(nodeJSEmps, isLeavePage),
                  SizedBox(height: 10.0,),
                  Text('UI/UX',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  ListViewBuilderWidget(uIUXEmps, isLeavePage),
                  SizedBox(height: 10.0,),
                  Text('Digital Marketing',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  ListViewBuilderWidget(digitalMarketingEmps, isLeavePage),
                  SizedBox(height: 10.0,),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

Widget ListViewBuilderWidget(List deptEmpList, bool isLeavePage) {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: deptEmpList.length,
    itemBuilder: (context, index) {

      // Access the filtered employee at the current index
      final employee = deptEmpList[index];

      // Now you can build your ListTile or any other widget for displaying employee data
      return GestureDetector(
        onTap: () async {
          if(isLeavePage) {
            QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('leaves')
                .doc('${employee.empID}')
                .collection('leavesList')
                .get();

            getXController.leaves.value =
                querySnapshot.docs.map((doc) => Leave.fromMap(doc.data())).toList();

            Get.toNamed('/leavePage', arguments: {'empID': '${employee.empID}'});
          } else {
            QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('tasks')
                .doc('${employee.empID}')
                .collection('tasksList')
                .get();

            getXController.tasks.value =
                querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();

            Get.toNamed('/taskPage', arguments: {'empID': '${employee.empID}'});
          }
        },
        onLongPress: () async {
          String profileImgLink;
          DocumentSnapshot<Map<String, dynamic>> profileImageSnapshot =
          await FirebaseFirestore.instance
              .collection('profileImages')
              .doc('${employee.empID}')
              .get();
          if(profileImageSnapshot.exists) {
            profileImgLink = profileImageSnapshot.data()!['imgUrl'];
          } else {
            profileImgLink = 'https://firebasestorage.googleapis.com/v0/b/hrmsystem-6a062.appspot.com/o/images%2FprofileImageDefault.png?alt=media&token=7a43fc33-4feb-4b8a-a4fd-5e58ca2eb089';
          }
          Get.dialog(
            Dialog(
              child: EmployeeInfoDialog(profileImgLink: profileImgLink, employee: employee),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            tileColor: AppColor.blue50,
            title: Text(employee.empName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(employee.empJobTitle),
                Row(
                  children: [
                    Icon(Icons.mail_outlined,
                      size: 18.0,
                    ),
                    SizedBox(width: 5.0,),
                    Text(employee.empEmail),
                  ],
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ),
        ),
      );
    },
  );
}
