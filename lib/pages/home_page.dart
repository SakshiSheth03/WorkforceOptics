import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/utils/current_user_info.dart';
import '../models/homePageController.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../utils/app_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomePageController homePageController = Get.put(HomePageController());

  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12.0, 12.0, 2.0, 6.0),
            child: Obx(() => Text('Welcome, ${CurrentUserInfo.empName.value}',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined),
                SizedBox(width: 10.0,),
                Text('${homePageController.toadyTime.day}-${months[homePageController.toadyTime.month-1]}-${homePageController.toadyTime.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                // Text('${homePageController.toadyTime.hour}:${homePageController.toadyTime.minute}:${homePageController.toadyTime.second}'),
              ],
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.circle,
                // border: Border.all(
                //   color: AppColor.grey300,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.grey300,
                    blurRadius: 5.0,
                    offset: Offset(0, 0),
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(15.0),
              child: Obx(() => CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: homePageController.percent.value/100,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 90.0,
                  lineWidth: 10.0,
                  progressColor: AppColor.pieChartGreen,
                  // progressColor: Colors.red,
                  center: Text('${homePageController.time.value}',
                      style: TextStyle(
                        color: AppColor.blue900,
                        fontSize: 25.0,
                      ),
                    ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatusContainer(context, 'Checked In', '09:28 AM'),
                StatusContainer(context, 'Checked Out', '...'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatusContainer(context, 'Break Time', '01:15-02:00 PM'),
                Obx(() => StatusContainer(context, 'Overtime', homePageController.overtime.value)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.transparent,
            ),
            margin: EdgeInsets.only(top: 10.0, left: 6.0),
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ListViewContainer(AppColor.green100, 'Tasks', 'Daily work', '/taskPage', Icons.task),
                ListViewContainer(AppColor.red100, 'Leave', 'Request Day Off', '/leavePage', Icons.calendar_month_outlined),
                ListViewContainer(AppColor.blue100, 'Work Report', 'Track your progress', '/workReportPage', Icons.bar_chart),
                ListViewContainer(AppColor.yellow100, 'Team', 'Know your team-mates', '/teamPage', Icons.person_add_alt_1),
                ListViewContainer(AppColor.purple100, 'Department  & Employees', 'Colleagues',  '/deptEmpPage', Icons.pie_chart),
                ListViewContainer(AppColor.teal100, 'Festivals/Holidays', 'List of Day Offs',  '/festivalsPage', Icons.calendar_month),
                ListViewContainer(AppColor.orange100, 'Birthdays', 'List of Birthdates', '/birthdaysPage', Icons.cake),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget StatusContainer(context, String status, String time) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: AppColor.grey300,
          blurRadius: 10.0,
        ),
      ],
    ),
    height: MediaQuery.of(context).size.width*0.18,
    width: MediaQuery.of(context).size.width*0.45,
    padding: EdgeInsets.only(left: 15.0),
    margin: EdgeInsets.all(5.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(status,
          style: TextStyle(
            color: AppColor.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(time,
          style: TextStyle(
            color: AppColor.blue900,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );
}

Widget ListViewContainer(Color color, String title, String subtitle, String path, IconData icon) {
  return GestureDetector(
    onTap: () => Get.toNamed(path),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: color,
      ),
      height: 200.0,
      width: 150.0,
      margin: EdgeInsets.all(7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.black,
              ),
            ),
            // height: 30.0,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(left: 15.0),
            child: Icon(icon),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0),
            child: Text(title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(subtitle,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
