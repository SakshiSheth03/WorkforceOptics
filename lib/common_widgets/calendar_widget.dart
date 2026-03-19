import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calendar_controller.dart';

class CalendarWidget extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: calendarController.focusedDay.value,
            selectedDayPredicate: (day) => isSameDay(calendarController.selectedDay.value, day),
            eventLoader: (day) => calendarController.getEventsForDay(day),
            onDaySelected: (selectedDay, focusedDay) {
              calendarController.selectedDay.value = selectedDay;
              calendarController.focusedDay.value = focusedDay;
            },
            daysOfWeekHeight: 22.0,
            calendarFormat: CalendarFormat.month,
            // onFormatChanged: (format) {
            //   if (calendarController.calendarFormat.value != format) {
            //     calendarController.calendarFormat.value = format;
            //     calendarController.update();
            //   }
            // },
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(
                color: Colors.grey[400],
              ),
              cellMargin: EdgeInsets.only(bottom: 20.0),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColor.blue900,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColor.blue900.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white),
              markersAlignment: Alignment.bottomCenter,
            ),
            rowHeight: 55.0,
          );
        }),
        SizedBox(height: 5),
      ],
    );
  }
}
