import 'package:flutter/material.dart';
import 'package:hrms_system/utils/app_colors.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  String method;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: AppColor.white,
      title: Text('${method} Task',
        style: TextStyle(
          color: Color(0xFF000000),
        ),
      ),
      content: Container(
        height: 120.0,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

            //get user input
            TextField(
              controller: controller,
              cursorColor: AppColor.blue900,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: AppColor.blue900,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: AppColor.blue900,
                    width: 2.0,
                  ),
                ),
                // enabledBorder: OutlineInputBorder(),
                hintText: method == 'Add' ? "Enter a new task" : "Edit the task",
                hintStyle: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),

            // buttons - save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //cancel button
                MaterialButton(
                  onPressed: onCancel,
                  color: AppColor.blue900,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),

                const SizedBox(width: 10.0),

                //save button
                MaterialButton(
                  onPressed: onCancel,
                  color: AppColor.blue900,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
