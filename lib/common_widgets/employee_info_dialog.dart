import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/employee.dart';

Widget EmployeeInfoDialog({required String profileImgLink,required Employee employee,}) {
  return Container(
    padding: EdgeInsets.all(25.0),
    height: 530.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white,
                image: DecorationImage(image: NetworkImage(profileImgLink),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(3.0),
              margin: EdgeInsets.only(right: 15.0),
              child: CircleAvatar(
                radius: 35.0,
                backgroundColor: AppColor.transparent,
              ),
            ),
            SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0,),
                Text(employee.empName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('${employee.empID}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 15.0,),
        Text('Employment Details',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.pie_chart, textDetail: '${employee.empDept}'),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.abc, textDetail: '${employee.empJobTitle}'),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.timelapse, textDetail: '${employee.empStatus}'),
        // SizedBox(height: 10.0),
        // RowDetails(icon: Icons.star, textDetail: '${employee.empPerformanceRatings}'),
        // SizedBox(height: 10.0),
        // RowDetails(icon: Icons.bar_chart, textDetail: '${employee.empAchievements}'),
        SizedBox(height: 20.0,),
        Text('Personal Details',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.email, textDetail: '${employee.empEmail}'),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.phone, textDetail: '${employee.empPhNum}'),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.cake, textDetail: '${employee.empDOB.day.toString().padLeft(2, "0")}/${employee.empDOB.month.toString().padLeft(2, "0")}/${employee.empDOB.year}'),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.bloodtype, textDetail: '${employee.empBldGrp}'),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.flag, textDetail: '${employee.empNationality}'),
        SizedBox(height: 10.0),
        RowDetails(icon: Icons.language, textDetail: '${employee.empLang}'),
      ],
    ),
  );
}

Widget RowDetails({required IconData icon, required String textDetail}) {
  return Row(
    children: [
      SizedBox(width: 10.0,),
      Icon(icon),
      SizedBox(width: 10.0,),
      Expanded(child: Text(textDetail)),
    ],
  );
}
