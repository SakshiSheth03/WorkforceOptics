import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../models/my_controller.dart';
import '../utils/current_user_info.dart';

class HomePageAdmin extends StatelessWidget {
  HomePageAdmin({super.key});

  MyController getXController = Get.find();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12.0, 12.0, 2.0, 6.0),
            child: Text('Welcome, ${CurrentUserInfo.empName}',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            margin: EdgeInsets.only(top: 10.0, left: 6.0),
            child: GridView(
              key: Key('unique'),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                GridViewContainer(AppColor.green100, 'Assign Tasks', 'Daily work', '/taskPageAdmin', Icons.task),
                GridViewContainer(AppColor.red100, 'Leave Requests', 'Approve/Reject', '/leavePageAdmin', Icons.calendar_month_outlined),
                GridViewContainer(AppColor.yellow100, 'Add Employee', 'New Joining', '/addEmployeePage', Icons.person_add_alt_1),
                GridViewContainer(AppColor.purple100, 'Department  & Employees', 'Colleagues',  '/deptEmpPage', Icons.pie_chart),
                GridViewContainer(AppColor.blue100, 'Festivals/Holidays', 'List of Day Offs', '/festivalsPage', Icons.calendar_month),
                GridViewContainer(AppColor.teal100, 'Birthdays', 'List of Birthdates', '/birthdaysPage', Icons.cake),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget StatusContainer(context, String status, String time) {
//   return Container(
//     decoration: BoxDecoration(
//       color: AppColor.white,
//       borderRadius: BorderRadius.circular(12.0),
//       boxShadow: [
//         BoxShadow(
//           color: AppColor.grey300,
//           blurRadius: 10.0,
//         ),
//       ],
//     ),
//     height: MediaQuery.of(context).size.width*0.18,
//     width: MediaQuery.of(context).size.width*0.45,
//     padding: EdgeInsets.only(left: 15.0),
//     margin: EdgeInsets.all(5.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(status,
//           style: TextStyle(
//             color: AppColor.black,
//             fontSize: 14.0,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         Text(time,
//           style: TextStyle(
//             color: AppColor.blue900,
//             fontSize: 18.0,
//             fontWeight: FontWeight.w500,
//           ),
//         )
//       ],
//     ),
//   );
// }

Widget GridViewContainer(Color color, String title, String subtitle, String path, IconData icon) {
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
