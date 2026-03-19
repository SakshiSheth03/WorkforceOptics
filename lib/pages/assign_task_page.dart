import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/utils/input_controllers.dart';
import 'package:hrms_system/utils/textFormFieldValidator.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import '../utils/helperMethods.dart';

class AssignTaskPage extends StatefulWidget {
  const AssignTaskPage({super.key});

  @override
  State<AssignTaskPage> createState() => _AssignTaskPageState();
}

class _AssignTaskPageState extends State<AssignTaskPage> {

  final GlobalKey<FormState> assignTaskFormKey = GlobalKey<FormState>();

  String empID = Get.arguments['empID'];

  onTapFunction({required BuildContext context, required DateTime firstDate, required DateTime lastDate, required initialDate, required TextEditingController controller}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: lastDate,
      firstDate: firstDate,
      initialDate: initialDate,
    );
    if (pickedDate == null) return;
    controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    // datePickerController.text = pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.blue900,
            foregroundColor: AppColor.white,
            title: Text('Assign Task'),
            toolbarHeight: 65.0,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                    child: Form(
                      key: assignTaskFormKey,
                      child: Column(
                        children: [
                          TextFormFieldWidget('Task Title', InputControllers.taskTitleController, Validator.validateNotNull),
                          TextFormFieldWidget('Description', InputControllers.taskDescriptionController, Validator.validateNotNull),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: InputControllers.taskDeadlineController,
                            readOnly: true,
                            validator: Validator.validateNotNull,
                            decoration: InputDecoration(
                              labelText: 'Deadline Date',
                              // hintText: "Click here to select date",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue.shade900, width: 0.8),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onTap: () => onTapFunction(context: context, firstDate: DateTime.now(), lastDate: DateTime(2025), initialDate: DateTime.now(), controller: InputControllers.taskDeadlineController),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.9, 50.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () async{
                      try {
                        print("***************************************************************");
                        bool check = assignTaskFormKey.currentState!.validate();
                        print("***************************************************************");
                        if(check) {
                          print("***************************************************************");
                          await HelperMethods.assignTask(empID);
                          print("***************************************************************");
                          Get.back();
                        }
                      } catch (e) {
                        print('Error assigning task: $e');
                      }
                    },
                    child: Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
            ),
          ),
        )
    );
  }
}

class DropdownButtonFormField2Widget extends StatefulWidget {

  List<String> items;
  String? selectedValue;
  String hint;

  DropdownButtonFormField2Widget({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.hint
  });

  @override
  State<DropdownButtonFormField2Widget> createState() => _DropdownButtonFormField2WidgetState();
}

class _DropdownButtonFormField2WidgetState extends State<DropdownButtonFormField2Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 20.0),
      child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<String>(
            isDense: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value == null ? '*Required' : null,
            isExpanded: true,
            decoration: InputDecoration(
              label: Text(widget.hint),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade900, width: 0.8),
                borderRadius: BorderRadius.circular(15.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black,
                    spreadRadius: 0.0,
                    blurRadius: 0.0,
                    offset: Offset(0, 0),
                  ),
                ],
                // border: Border.all(color: Colors.blue.shade900, width: 1.0),
              ),
            ),
            items: widget.items.map((String item) => DropdownMenuItem(
                value: item,
                child: Text(item,
                  style:TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ) ,
                )
            )).toList(),
            value: widget.selectedValue,
            // value: 'Admin',
            onChanged: (String? value){
              setState(() {
                widget.selectedValue=value;
                // if(widget.hint == 'Blood Group') {
                InputControllers.typeOfLeaveController.text = value!;
                // } else if(widget.hint == 'Employment Status') {
                //   InputControllers.employmentStatusController.text = value!;
                // } else if(widget.hint == 'Department') {
                //   InputControllers.departmentController.text = value!;
                // } else {}
              });
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.all(0.0),
              width: double.infinity,
            ),
          )
      ),
    );
  }
}

Widget TextFormFieldWidget(String labelHint, TextEditingController _controller, String? Function(String?) validate) {
  return Column(
    children: [
      SizedBox(height: 18.0,),
      TextFormField(
        maxLines: labelHint == 'Description'? 4 : 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _controller,
        decoration: InputDecoration(
          labelText: labelHint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade900, width: 0.8),
            borderRadius: BorderRadius.circular(15.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        validator: validate,
      ),
    ],
  );
}
