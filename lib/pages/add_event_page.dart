import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/calendar_controller.dart';
import '../utils/app_colors.dart';

class AddEventPage extends StatelessWidget {
  final CalendarController calendarController = Get.find();
  final _formKeyCalendar = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blue50,
        appBar: AppBar(
          foregroundColor: AppColor.white,
          backgroundColor: AppColor.blue900,
          title: Text('Add Event',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          toolbarHeight: 65.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKeyCalendar,
            child: ListView(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      dateController.text = picked.toString().split(' ')[0];
                    }
                  },
                ),
                TextFormField(
                  controller: startTimeController,
                  decoration: InputDecoration(labelText: 'Start Time'),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      startTimeController.text = picked.format(context);
                    }
                  },
                ),
                TextFormField(
                  controller: endTimeController,
                  decoration: InputDecoration(labelText: 'End Time'),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      endTimeController.text = picked.format(context);
                    }
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKeyCalendar.currentState!.validate()) {
                        final event = {
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'startTime' : startTimeController.text,
                          'endTime' : endTimeController.text,
                        };
                        final date = DateTime.parse(dateController.text);
                        calendarController.addEvent(date, event);
                        Get.back();
                      }
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
                    child: Text('Add',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}