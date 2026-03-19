import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/common_widgets/employee_info_dialog.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:hrms_system/models/my_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DepartmentsEmployees extends StatelessWidget {
  DepartmentsEmployees({super.key});

  MyController getXController = Get.find();


  @override
  Widget build(BuildContext context) {

    final flutterEmps = MyController.empList.where((employee) => employee.empDept == 'Flutter').toList();
    final reactJSEmps = MyController.empList.where((employee) => employee.empDept == 'ReactJS').toList();
    final nodeJSEmps = MyController.empList.where((employee) => employee.empDept == 'NodeJS').toList();
    final uIUXEmps = MyController.empList.where((employee) => employee.empDept == 'UI/UX').toList();
    final digitalMarketingEmps = MyController.empList.where((employee) => employee.empDept == 'Digital Marketing').toList();

    final List<ChartData> chartData = [
      ChartData('Flutter', flutterEmps.length, AppColor.pieChartBlue),
      ChartData('ReactJS', reactJSEmps.length, AppColor.pieChartPurple),
      ChartData('NodeJS', nodeJSEmps.length, AppColor.pieChartPink),
      ChartData('UI/UX', uIUXEmps.length, AppColor.pieChartYellow),
      ChartData('Digital Marketing', digitalMarketingEmps.length, AppColor.pieChartGreen),
    ].obs;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: AppColor.white,
            backgroundColor: AppColor.blue900,
            title: Text('Departments and Employees',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            toolbarHeight: 65.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 300,
                      child: SfCircularChart(
                            series: <CircularSeries>[
                              // Renders doughnut chart
                              DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelMapper: (ChartData data, _) => data.x,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  useSeriesColor: true,
                                  labelPosition: ChartDataLabelPosition.outside,
                                ),
                                enableTooltip: true,
                              ),
                            ],
                        ),
                  ),
                ),
                DepartmentEmployeeTile(getXController, 'Flutter', flutterEmps, AppColor.pieChartBlue),
                DepartmentEmployeeTile(getXController, 'ReactJS', reactJSEmps, AppColor.pieChartPurple),
                DepartmentEmployeeTile(getXController, 'NodeJS', nodeJSEmps, AppColor.pieChartPink),
                DepartmentEmployeeTile(getXController, 'UI/UX', uIUXEmps, AppColor.orange700),
                DepartmentEmployeeTile(getXController, 'Digital Marketing', digitalMarketingEmps, AppColor.pieChartGreen),
                SizedBox(height: 10.0,),
              ],
            ),
          )
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

Widget DepartmentEmployeeTile(MyController getXController, String empDept, List empLst, Color textColor) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: AppColor.blue50,
    ),
    margin: EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(empDept,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: textColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: MyController.empList.where((employee) => employee.empDept == empDept).length,
          itemBuilder: (context, index) {

            // Access the filtered employee at the current index
            final employee = empLst[index];

            // Now you can build your ListTile or any other widget for displaying employee data
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
                        Icon(Icons.mail_outlined,
                          size: 18.0,
                        ),
                        SizedBox(width: 5.0,),
                        Text(employee.empEmail),
                      ],
                    ),
                  ],
                ),
                // Add more details here as needed
              ),
            );
          },
        ),
      ],
    ),
  );
}