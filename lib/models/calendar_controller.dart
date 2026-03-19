import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  var events = <DateTime, List<Map<String, String>>>{
    DateTime(2024, 5, 2): [
      {'title': 'Flutter Backend Team Meeting', 'description': 'Regarding database structure - Meeting Room 2', 'startTime': '02:00 PM', 'endTime': '03:00 PM'},
      {'title': 'ReactJS Client Call', 'description': 'Shopify website design to be finalized', 'startTime': '03:30 PM', 'endTime': '04:00 PM'},
    ],
    DateTime(2024, 5, 7): [
      {'title': 'Shopify website API Design', 'description': 'NodeJS Team Meeting - Meeting Room 1','startTime': '11:00 AM', 'endTime': '11:30 AM'},
    ],
    DateTime(2024, 5, 8): [
      {'title': 'HRMS Project Testing', 'description': 'QA Team Meeting - Meeting Room 2','startTime': '11:00 AM', 'endTime': '11:30 AM'},
    ],
    DateTime(2024, 5, 10): [
      {'title': 'Digital Marketing Team Meeting', 'description': 'Social Media Posts Designing - Meeting Room 1','startTime': '11:00 AM', 'endTime': '11:30 AM'},
    ],
    DateTime(2024, 5, 13): [
      {'title': 'NodeJS Team Scrum Meeting', 'description': 'Discussions - Meeting Room 3','startTime': '11:00 AM', 'endTime': '11:30 AM'},
      {'title': 'Flutter Team Scrum Meeting', 'description': 'Discussions - Meeting Room 2','startTime': '11:15 AM', 'endTime': '11:35 AM'},
    ],
    DateTime(2024, 5, 15): [
      {'title': 'HRMS Project Deadline', 'description': 'Flutter Team Meeting - Meeting Room 3','startTime': '10:00 AM', 'endTime': '11:00 AM'},
    ],
    DateTime(2024, 5, 16): [
      {'title': 'Shopify website payment gateway inclusion', 'description': 'Shopify Backend Team Meeting - Meeting Room 2','startTime': '03:00 PM', 'endTime': '03:30 PM'},
    ],
    DateTime(2024, 5, 17): [
      {'title': 'HRMS Project Deployment', 'description': 'Flutter Team Meeting with Client- Meeting Room 1','startTime': '10:00 AM', 'endTime': '01:00 PM'},
    ],
    DateTime(2024, 5, 20): [
      {'title': 'HRMS Client Feedback Call', 'description': 'Maintenance Phase-1 Commencement','startTime': '02:30 PM', 'endTime': '03:00 PM'},
    ],
  }.obs;
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  // Rx<CalendarFormat?> calendarFormat = Rx<CalendarFormat?>(null);
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  List<Map<String, String>> getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void addEvent(DateTime date, Map<String, String> event) {
    DateTime eventDate = DateTime(date.year, date.month, date.day);
    if (events.containsKey(eventDate)) {
      events[eventDate]!.add(event);
    } else {
      events[eventDate] = [event];
    }
    update(); // Ensure the state is updated
  }
}
