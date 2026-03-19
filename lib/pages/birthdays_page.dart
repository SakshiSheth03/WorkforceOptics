import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // To format the date
import '../common_widgets/employee_info_dialog.dart';
import '../models/my_controller.dart';
import '../utils/app_colors.dart';
import '../utils/employee.dart'; // Make sure to import your controller

class BirthDatesPage extends StatelessWidget {
  MyController getXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: AppColor.white,
            backgroundColor: AppColor.blue900,
            title: Text('Employee Birth Dates',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            toolbarHeight: 65.0,
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: AppColor.red100,
              labelColor: AppColor.red100,
              unselectedLabelColor: AppColor.white,
              tabs: List.generate(12, (index) {
                return Tab(text: DateFormat('MMMM').format(DateTime(0, index + 1)));
              }),
            ),
          ),
          body: TabBarView(
            children: List.generate(12, (index) {
              return Obx(() {
                List<dynamic> employees = getXController.getBirthdaysByMonth(index + 1);
                if (employees.isEmpty) {
                  return Center(child: Text('No Birthdays'));
                }
                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    Employee employee = employees[index];
                    return GestureDetector(
                      onTap: () async{
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
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColor.blue50,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
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
                                  Icon(Icons.cake,
                                    size: 18.0,
                                  ),
                                  SizedBox(width: 5.0,),
                                  Text(DateFormat('dd MMMM').format(employee.empDOB)),
                                ],
                              ),
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
                        ),
                      ),
                    );
                  },
                );
              });
            }),
          ),
        ),
      ),
    );
  }
}
