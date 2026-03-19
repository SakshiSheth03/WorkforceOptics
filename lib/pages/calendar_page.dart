import 'package:flutter/material.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hrms_system/utils/current_user_info.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../common_widgets/calendar_widget.dart';
import '../models/calendar_controller.dart';
import 'add_event_page.dart';

class CalendarPage extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StickyHeader(
            header: Container(
              decoration: BoxDecoration(
                color: AppColor.blue900,
              ),
              padding: EdgeInsets.all(15.0),
              width: double.infinity,
              child: Text(
                'Calendar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColor.blue50,
              ),
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(8.0),
              child: CalendarWidget(),
            ),
          ),
          Obx(() {
            final events = calendarController.getEventsForDay(calendarController.selectedDay.value);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...events.map((event) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: AppColor.blue900, width: 1.0),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event['title'] ?? '',
                          style: TextStyle(fontSize: 16.0, color: AppColor.blue900, fontWeight: FontWeight.w500),
                        ),
                        Text(event['description'] ?? ''),
                        Row(
                          children: [
                            Text('From: ', style: TextStyle(color: AppColor.blue900, fontWeight: FontWeight.w500),),
                            Text('${event['startTime'] ?? ''}'),
                            Text(' to ', style: TextStyle(color: AppColor.blue900, fontWeight: FontWeight.w500),),
                            Text('${event['endTime'] ?? ''}'),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
                if (events.isEmpty)
                  Center(child: Text('No events for this day.', style: TextStyle(color: Colors.grey))),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CurrentUserInfo.role.value == 'Admin'? ElevatedButton(
                    onPressed: () {
                      Get.to(() => AddEventPage());
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.7, 50.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      'Add Event',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ) : null,
                ),
                SizedBox(height: 20.0,),
              ],
            );
          }),
        ],
      ),
    );
  }
}