import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../utils/app_colors.dart';

class WorkReportPage extends StatelessWidget {
  WorkReportPage({super.key});

  List<_ChartData> data1 = [
    _ChartData('MON', 8.01),
    _ChartData('TUE', 7.66),
    _ChartData('WED', 8.56),
    _ChartData('THU', 9.00),
    _ChartData('FRI', 7.8)
  ];
  List<_ChartData> data2 = [
    _ChartData('MON', 7.5),
    _ChartData('TUE', 8.2),
    _ChartData('WED', 0.0),
    _ChartData('THU', 0.0),
    _ChartData('FRI', 0.0)
  ];
  TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: AppColor.white,
            backgroundColor: AppColor.blue900,
            title: Text('Work Report',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            toolbarHeight: 65.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22.0, 12.0, 22.0, 20.0),
                  child: Text('Track your working hours, maintain the consistency and stay up to date!',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DateContainer('Mon', '13'),
                    DateContainer('Tue', '14'),
                    DateContainer('Wed', '15'),
                    DateContainer('Thu', '16'),
                    DateContainer('Fri', '17'),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.grey300,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                  width: double.infinity,
                  child: Text('Total Hours: 16:14 Hrs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: AppColor.grey300,
                      width: 2.5,
                    ),
                  ),
                  height: 480.0,
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(8.0),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(minimum: 0, maximum: 12, interval: 1),
                      tooltipBehavior: _tooltip,
                      margin: EdgeInsets.only(top: 20.0, right: 5.0),
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        alignment: ChartAlignment.near,
                        orientation: LegendItemOrientation.horizontal,
                        iconHeight: 18.0,
                        iconWidth: 15.0,
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                        title: LegendTitle(
                          text: 'Hours Worked',
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                          alignment: ChartAlignment.near,
                        ),
                        padding: 10.0,
                      ),
                      series: <CartesianSeries<_ChartData, String>>[
                        ColumnSeries<_ChartData, String>(
                            dataSource: data1,
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'Previous Weeks',
                            color: AppColor.pieChartGreen,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0) ),
                            animationDuration: 800,
                        ),
                        ColumnSeries<_ChartData, String>(
                            dataSource: data2,
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'This Week',
                            color: AppColor.yellow800,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0) ),
                            animationDuration: 800,
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

Widget DateContainer(String day, String date) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: AppColor.grey300,
          offset: Offset(2.0, 2.0),
          blurRadius: 4.0,
          spreadRadius: 1.0,
        )
      ],
      color: date == '15' ? AppColor.blue50 : AppColor.white,
      borderRadius: BorderRadius.circular(5.0),
    ),
    width: 50.0,
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      children: [
        Text(day),
        Text(date,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );
}