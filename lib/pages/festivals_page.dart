import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class FestivalsPage extends StatefulWidget {
  const FestivalsPage({super.key});

  @override
  State<FestivalsPage> createState() => _FestivalsPageState();
}

class _FestivalsPageState extends State<FestivalsPage> {
  bool isAprilExpanded = true;
  bool isMayExpanded = false;
  bool isJuneExpanded = false;
  bool isJulyExpanded = false;
  bool isAugustExpanded = false;
  bool isSeptemberExpanded = false;
  bool isOctoberExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 65.0,
            foregroundColor: AppColor.white,
            backgroundColor: AppColor.blue900,
            title: Text('Festivals/Holidays',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // April Month
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAprilExpanded = !isAprilExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('April 2024',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_drop_down,
                              size: 26.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        isAprilExpanded? Text('09 - TUE - Ugadi/Gudi Padwa', style: TextStyle(fontSize: 15.0),) : Row(),
                        isAprilExpanded? Text('13 - SAT - Baisakhi', style: TextStyle(fontSize: 15.0),) : Row(),
                        isAprilExpanded? Text('17 - WED - Ramnavami', style: TextStyle(fontSize: 15.0),) : Row(),
                      ],
                    ),
                  ),
                ),

                // May Month
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMayExpanded = !isMayExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('May 2024',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_drop_down,
                              size: 26.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        isMayExpanded? Text('10 - FRI - Akshay Tritiya', style: TextStyle(fontSize: 15.0),) : Row(),
                      ],
                    ),
                  ),
                ),

                // June Month
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isJuneExpanded = !isJuneExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('June 2024',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_drop_down,
                              size: 26.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        isJuneExpanded? Text('21 - FRI - International Yoga Day', style: TextStyle(fontSize: 15.0),) : Row(),
                      ],
                    ),
                  ),
                ),

                // July Month
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isJulyExpanded = !isJulyExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('July 2024',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_drop_down,
                              size: 26.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        isJulyExpanded? Text('07 - SUN - Rath Yatra', style: TextStyle(fontSize: 15.0),) : Row(),
                        isJulyExpanded? Text('21 - SUN - Guru Purnima', style: TextStyle(fontSize: 15.0),) : Row(),
                      ],
                    ),
                  ),
                ),

                // August Month
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAugustExpanded = !isAugustExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('August 2024',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_drop_down,
                              size: 26.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        isAugustExpanded? Text('15 - THU - Independence Day', style: TextStyle(fontSize: 15.0),) : Row(),
                        isAugustExpanded? Text('19 - MON - Rakshabandhan', style: TextStyle(fontSize: 15.0),) : Row(),
                        isAugustExpanded? Text('26 - MON - Janmashtami', style: TextStyle(fontSize: 15.0),) : Row(),
                      ],
                    ),
                  ),
                ),

                // September Month
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSeptemberExpanded = !isSeptemberExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('September 2024',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_drop_down,
                              size: 26.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        isSeptemberExpanded? Text('05 - THU - Teacher\'s Day', style: TextStyle(fontSize: 15.0),) : Row(),
                        isSeptemberExpanded? Text('07 - SAT - Ganesh Chaturthi', style: TextStyle(fontSize: 15.0),) : Row(),
                      ],
                    ),
                  ),
                ),

                // October Month
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOctoberExpanded = !isOctoberExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('October 2024',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_drop_down,
                              size: 26.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        isOctoberExpanded? Text('02 - WED - Gandhi Jayanti', style: TextStyle(fontSize: 15.0),) : Row(),
                        isOctoberExpanded? Text('12 - SAT - Dussehra', style: TextStyle(fontSize: 15.0),) : Row(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
              ],
            ),
          ),
        ),
    );
  }
}
