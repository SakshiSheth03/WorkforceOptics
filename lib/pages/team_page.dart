import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrms_system/utils/current_user_info.dart';
import 'package:get/get.dart';
import '../common_widgets/employee_info_dialog.dart';
import '../models/my_controller.dart';
import '../utils/app_colors.dart';

class TeamPage extends StatelessWidget {
  TeamPage({super.key});

  final empTeamList = MyController.empList.where((employee) => employee.empDept == CurrentUserInfo.empDept.value).toList();

  Map<String, String> description = {
    'Flutter':'The Flutter team drives cross-platform app development, i.e. Android, iOS, Web, etc.',
    'ReactJS': 'Developers proficient in building UIs using React, a popular JS library',
    'NodeJS': 'Specializes in building server-side applications and APIs using Node.js.',
    'UI/UX': 'Focuses on designing user interfaces and experiences to ensure visually appealing applications.',
    'Digital Marketing' : 'Drives online brand awareness through strategic digital campaigns and analytics.',
  };
  Map<String, String> ongoingProject = {
    'Flutter':'HRM System',
    'ReactJS': 'Brownie Dating App',
    'NodeJS': 'Shopify Website',
    'UI/UX': 'Brownie Dating App',
    'Digital Marketing' : 'Company awareness on Instagram',
  };
  Map<String, String> projectDeadline = {
    'Flutter':'15/05/2024',
    'ReactJS': '06/06/2024',
    'NodeJS': '30/05/2024',
    'UI/UX': '31/05/2024',
    'Digital Marketing' : '17/05/2024',
  };
  Map<String, String> GOA = {
    'Flutter':'Empower Flutter to excel in complex UI designs and interactions across platforms.',
    'ReactJS': 'Develop high-quality, maintainable, and scalable user interfaces leveraging ReactJS',
    'NodeJS': 'To develop high-performance, scalable backend solutions that seamlessly integrate with front-end applications.',
    'UI/UX': ' Create seamless and engaging user experiences through innovative and user-centered design solutions.',
    'Digital Marketing' : 'Enhance brand visibility, generate leads, and optimize online campaigns for maximum ROI.',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColor.white,
          backgroundColor: AppColor.blue900,
          title: Obx(() => Text('${CurrentUserInfo.empDept.value} Team',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          toolbarHeight: 65.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: AppColor.grey300,
                      width: 2.0
                    ),
                  ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Image.asset('assets/images/team1.jpg'),
                        Text('Total ${empTeamList.length} Employees',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 20.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        color: AppColor.grey300,
                        width: 2.0
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Manager : Sakshi Sheth',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('Description : ${description['${CurrentUserInfo.empDept.value}']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('Ongoing Project: ${ongoingProject['${CurrentUserInfo.empDept.value}']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('Project Deadline: ${projectDeadline['${CurrentUserInfo.empDept.value}']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('Goals and Objectives: ${GOA['${CurrentUserInfo.empDept.value}']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                ListViewBuilderWidget(empTeamList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget ListViewBuilderWidget(List deptEmpList) {
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

