import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/events.dart';
import 'package:flutter/material.dart';

class CalendarPageController extends GetxController {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  RxMap<DateTime, List<Events>> events = {
    DateTime(2024, 3, 29) : [Events(title: 'BDay')],
  }.obs;

  final selectedEvents = [].obs;

  final List<DateTime> toHighlight = [
    DateTime(2024, 3, 6),
    DateTime(2024, 3, 26)
  ];

  void init() {
    selectedDay = focusedDay;
  }

  List<Events> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.focusedDay = focusedDay;
    this.selectedDay = selectedDay;
    selectedEvents.value = getEventsForDay(selectedDay);
    update();
  }

  void addEventDialog(BuildContext context) {
    TextEditingController _eventController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: Text("Event Name"),
            content: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _eventController,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final List<Events> existingEvents =
                      events[selectedDay!] ?? [];
                  existingEvents.add(Events(title: _eventController.text));
                  events[selectedDay!] = existingEvents;
                  update();
                  Navigator.of(context).pop();
                },
                child: Text("Submit"),
              ),
            ],
          );
        });
  }

}
