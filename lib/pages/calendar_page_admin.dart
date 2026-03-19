import 'package:flutter/material.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import '../models/calendarPageController.dart';

// class CalendarPageAdmin extends StatefulWidget {
//   const CalendarPageAdmin({super.key});
//
//   @override
//   State<CalendarPageAdmin> createState() => _CalendarPageAdminState();
// }

// class _CalendarPageAdminState extends State<CalendarPageAdmin> {
//   TextEditingController _eventController = TextEditingController();
//
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focuedDay = DateTime.now();
//   DateTime? _selectedDay;
//
//   Map<DateTime, List<Events>> events = {};
//   late final ValueNotifier<List<Events>> _selectedEvents;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _selectedDay = _focuedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   }
//
//   List<Events> _getEventsForDay(DateTime day) {
//     // print(events[day]);
//     // return all the events from the selected date
//     return events[day] ?? [];
//   }
//
//   final List<DateTime> toHighlight = [
//     DateTime(2024, 3, 6),
//     DateTime(2024, 3, 26)
//   ];
//
//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     setState(() {
//       _focuedDay = focusedDay;
//       _selectedDay = selectedDay;
//       _selectedEvents.value = _getEventsForDay(selectedDay!);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: AppColor.blue900,
//             ),
//             padding: EdgeInsets.all(15.0),
//             width: double.infinity,
//             child: Text(
//               'Calendar',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AppColor.white,
//                 fontSize: 22.0,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15.0),
//               color: AppColor.blue50,
//             ),
//             margin: EdgeInsets.all(10.0),
//             padding: EdgeInsets.all(5.0),
//             child: TableCalendar(
//               locale: "en_US",
//               firstDay: DateTime.utc(2023, 4, 1),
//               lastDay: DateTime.utc(2024, 3, 31),
//               focusedDay: _focuedDay,
//               calendarFormat: _calendarFormat,
//               eventLoader: _getEventsForDay,
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               startingDayOfWeek: StartingDayOfWeek.monday,
//               calendarStyle: CalendarStyle(
//                 outsideDaysVisible: false,
//                 weekendTextStyle: TextStyle(
//                   color: Colors.grey[400],
//                 ),
//               ),
//               headerStyle: HeaderStyle(
//                 // formatButtonVisible: false,
//                 // titleCentered: true,
//               ),
//               availableGestures: AvailableGestures.all,
//               onDaySelected: _onDaySelected,
//               selectedDayPredicate: (_selectedDay) {
//                 return isSameDay(_selectedDay, _focuedDay);
//               },
//               calendarBuilders: CalendarBuilders(
//                 defaultBuilder: (context, day, focusedDay) {
//                   for (DateTime d in toHighlight) {
//                     if (day.day == d.day &&
//                         day.month == d.month &&
//                         day.year == d.year) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.yellow.shade800,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '${day.day}',
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ),
//           Text("Selected Day: " + _focuedDay.toString().split(" ")[0]),
//           SizedBox(
//             height: 20.0,
//           ),
//           ValueListenableBuilder(
//               valueListenable: _selectedEvents,
//               builder: (context, value, _) {
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: value.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin:
//                         EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//                         decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         child: ListTile(
//                           // onTap: (){},
//                           title: Text("${value[index].title}"),
//                         ),
//                       );
//                     });
//               }),
//           SizedBox(height: 20.0,),
//           ElevatedButton(
//               style: ButtonStyle(
//                 fixedSize: MaterialStateProperty.all(
//                     Size(MediaQuery.of(context).size.width * 0.9, 50.0)),
//                 shape: MaterialStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14.0),
//                   ),
//                 ),
//                 backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
//                 foregroundColor: MaterialStateProperty.all(Colors.white),
//               ),
//               child: Text(
//                 'Add Event',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         scrollable: true,
//                         title: Text("Event Name"),
//                         content: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: TextField(
//                             controller: _eventController,
//                           ),
//                         ),
//                         actions: [
//                           ElevatedButton(
//                               onPressed: () {
//                                 final List<Events> existingEvents =
//                                     events[_selectedDay!] ?? [];
//                                 existingEvents
//                                     .add(Events(title: _eventController.text));
//                                 events[_selectedDay!] = existingEvents;
//                                 _selectedEvents.value =
//                                     _getEventsForDay(_selectedDay!);
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text("Submit")),
//                         ],
//                       );
//                     });
//               }),
//           SizedBox(height: 20.0,),
//         ],
//       ),
//     );
//   }
// }

class CalendarPageAdmin extends StatelessWidget {
  final CalendarPageController controller = Get.put(CalendarPageController());

  @override
  Widget build(BuildContext context) {
    // final selectedEvents = controller.getEventsForDay(controller.selectedDay ?? DateTime.now());
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: AppColor.blue50,
            ),
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(5.0),
            child: GetBuilder<CalendarPageController>(
              builder: (controller) => TableCalendar(
                locale: "en_US",
                firstDay: DateTime.utc(2023, 4, 1),
                lastDay: DateTime.utc(2025, 3, 31),
                focusedDay: controller.focusedDay,
                calendarFormat: controller.calendarFormat,
                eventLoader: controller.getEventsForDay,
                onFormatChanged: (format) {
                  if (controller.calendarFormat != format) {
                    controller.calendarFormat = format;
                    controller.update();
                  }
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                headerStyle: HeaderStyle(),
                availableGestures: AvailableGestures.all,
                onDaySelected: (selectedDay, focusedDay) {
                  controller.onDaySelected(selectedDay, focusedDay);
                },
                selectedDayPredicate: (selectedDay) {
                  return isSameDay(selectedDay, controller.focusedDay);
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    for (DateTime d in controller.toHighlight) {
                      if (day.day == d.day &&
                          day.month == d.month &&
                          day.year == d.year) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade800,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          // Obx(() {
          //   return Text("Selected Day: ${controller.focusedDay.toString().split(" ")[0]}");
          // }),
          SizedBox(
            height: 20.0,
          ),
          Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.selectedEvents.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    onTap: () => print(""),
                    title: Text("${controller.selectedEvents[index].title}"),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.9, 50.0)),
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
              onPressed: () {
                controller.addEventDialog(context);
              }
          ),
        ],
      ),
    );
  }
}