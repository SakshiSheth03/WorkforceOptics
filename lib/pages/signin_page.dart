import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/common_widgets/text_form_field.dart';
import 'package:hrms_system/utils/input_controllers.dart';
import '../models/signInPageController.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hrms_system/models/auth.dart';

import '../utils/textFormFieldValidator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  SignInPageController signInPageController = Get.put(SignInPageController());

  final GlobalKey<FormState> signInPageFormKey = GlobalKey<FormState>();

  Future<bool> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: InputControllers.signInEmailController.text.trim(), password: InputControllers.signInPasswordController.text);
      return true;
    } on FirebaseAuthException catch (e) {
      signInPageController.errorMessage.value = e.message!;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              decoration: BoxDecoration(
                color: AppColor.transparent,
              ),
              child: Form(
                key: signInPageFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColor.blue900,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Obx(() => DropDownButtonWidget(icon: Icons.person, selectedValue: signInPageController.selectedValue.value, items: ['Admin', 'Employee'], hint: 'Select your role', onSelectedValueChanged: (value) => signInPageController.changeDropDownSelectedValue(value))),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormFieldWidget(hintText: 'Email address', icon: Icons.email, textController: InputControllers.signInEmailController, validate: Validator.validateEmail),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormFieldWidget(hintText: 'Password', icon: Icons.lock, textController: InputControllers.signInPasswordController, validate: Validator.validateNotNull),
                    Obx(() => SizedBox(height: signInPageController.errorMessage.value == ''? 0.0 : 20.0,)),
                    Obx(() => Center(child: Text(signInPageController.errorMessage.value == ''? '' : 'Error signing in: ${signInPageController.errorMessage.value}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.red,
                      ),
                    ),),),
                    GestureDetector(
                      onTap: () => Get.toNamed('/forgotPasswordPage'),
                      child: Container(
                        margin: EdgeInsets.only(top: 30.0),
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text('Forgot Password?'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Center(
                        child: ElevatedButton(
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
                          onPressed: () async {
                            try {
                              bool check = signInPageFormKey.currentState!.validate();
                              if(check) {
                                Get.toNamed('/loading');
                              }
                            } catch (e) {
                              print('Error signing in: $e');
                            }
                          },
                          child: Text('Submit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// DropDownButtonWidget
Widget DropDownButtonWidget({context,required IconData icon, required selectedValue, required List<String> items, required String hint, required ValueChanged<String> onSelectedValueChanged}) {

  String? _selectedValue;

  return Container(
    decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(25)
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Icon(icon,
            color: Colors.grey[800],
          ),
        ),
        DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0.5,
                      blurRadius: 2.0,
                      offset: Offset(2, 2),
                    ),
                  ],
                  // border: Border.all(color: Colors.blue.shade900),
                ),
                width: WidgetsBinding.instance.window.physicalSize.width * 0.33,
              ),
              hint: Text(hint),
              items: items.map((String item) => DropdownMenuItem(
                  value: item,
                  child: Text(item,
                    style:TextStyle(
                      fontSize: 14,
                    ) ,
                  )
              )).toList(),
              value: selectedValue,
              // value: 'Admin',
              onChanged: (String? value) {
                onSelectedValueChanged(value!);
              },
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(left: 12),
                height: 60,
                width: 260.0,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            )
        ),
      ],
    ),
  );
}

