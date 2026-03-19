import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_system/utils/helperMethods.dart';
import 'package:hrms_system/utils/input_controllers.dart';
import 'package:hrms_system/utils/textFormFieldValidator.dart';
import 'package:intl/intl.dart';
import '../models/my_controller.dart';

MyController getXController = Get.put(MyController());

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {

  final GlobalKey<FormState> addEmpFormKey = GlobalKey<FormState>();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        centerTitle: true,
        backgroundColor: AppColor.blue900,
        foregroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: addEmpFormKey,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.blue50,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal Information',
                      style: TextStyle(
                        color: AppColor.blue900,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormFieldWidget('Name', InputControllers.nameController, Validator.validateName),
                    TextFormFieldWidget('E-mail', InputControllers.emailController, Validator.validateEmail),
                    TextFormFieldWidget('Contact Number', InputControllers.contactNumController, Validator.validateContactNumber),
                    SizedBox(height: 18.0,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: InputControllers.birthDateController,
                      validator: Validator.validateBirthDate,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        // hintText: "Click here to select date",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade900, width: 0.8),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onTap: () => onTapFunction(context: context, firstDate: DateTime(1950),lastDate: DateTime(2005), initialDate: DateTime(2000), controller: InputControllers.birthDateController),
                    ),
                    DropdownButtonFormField2Widget(selectedValue: null, items: ['O+ve', 'O-ve', 'A+ve', 'A-ve', 'B+ve', 'B-ve', 'AB+ve', 'AB-ve'], hint: 'Blood Group',),
                    TextFormFieldWidget('Nationality', InputControllers.nationalityController, Validator.validateNationality),
                    TextFormFieldWidget('Languages Known', InputControllers.languagesController, Validator.validateLanguages),
                    TextFormFieldWidget('Address', InputControllers.addressController, Validator.validateAddress),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.blue50,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Employment Details',
                      style: TextStyle(
                        color: AppColor.blue900,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormFieldWidget('Job Title', InputControllers.jobTitleController, Validator.validateJobTitle),
                    DropdownButtonFormField2Widget(selectedValue: null, items: ['Full-Time', 'Part-Time', 'Internship'], hint: 'Employment Status',),
                    SizedBox(height: 18.0,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: InputControllers.joiningDateController,
                      readOnly: true,
                      validator: Validator.validateJoiningDate,
                      decoration: InputDecoration(
                        labelText: 'Joining Date',
                        // hintText: "Click here to select date",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade900, width: 0.8),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onTap: () => onTapFunction(context: context, firstDate: DateTime(2023), lastDate: DateTime(2025), initialDate: DateTime.now(), controller: InputControllers.joiningDateController),
                    ),
                    DropdownButtonFormField2Widget(selectedValue: null, items: ['Flutter', 'ReactJS', 'NodeJS', 'Digital Marketing', 'UI/UX'], hint: 'Department',),
                  ],
                ),
              ),
              ElevatedButtonWidget(context: context, buttonText: 'Add', nextRoute: '/addEmployeePage', formKey: addEmpFormKey),
              SizedBox(height: 30.0,),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TextFormFieldWidget(String labelHint, TextEditingController _controller, String? Function(String?) validate) {
  return Column(
    children: [
      SizedBox(height: 18.0,),
      TextFormField(
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
        // onTap: () => AlertDialog(
        //   title: Text('Select your date of birth'),
        //   content: SizedBox(
        //     height: 200,
        //     child: CupertinoDatePicker(
        //       mode: CupertinoDatePickerMode.date,
        //       initialDateTime: DateTime(2000, 1, 1),
        //       onDateTimeChanged: (DateTime newDateTime) {
        //         // Do something
        //       },
        //     ),
        //   ),
        // ),
      ),
    ],
  );
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
      margin: EdgeInsets.only(top: 20.0),
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
              width: MediaQuery.of(context).size.width * 0.82,
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
                if(widget.hint == 'Blood Group') {
                  InputControllers.bloodGroupController.text = value!;
                } else if(widget.hint == 'Employment Status') {
                  InputControllers.employmentStatusController.text = value!;
                } else if(widget.hint == 'Department') {
                  InputControllers.departmentController.text = value!;
                } else {}
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

Widget ElevatedButtonWidget({required context, required String buttonText, required String nextRoute, required GlobalKey<FormState> formKey}) {
  return ElevatedButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.85, 50.0)),
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
        bool check = formKey.currentState!.validate();
        if(check) {
          await HelperMethods.createNewEmployee();
        }
      } catch (e) {
        print('Error adding employee: $e');
      }
    },
    child: Text(buttonText,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
