import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hrms_system/utils/input_controllers.dart';
import '../models/auth.dart';
import '../models/forgotPasswordPageController.dart';
import '../common_widgets/text_form_field.dart';
import '../utils/app_colors.dart';
import '../utils/textFormFieldValidator.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    ForgotPasswordPageController forgotPasswordPageController = Get.put(ForgotPasswordPageController(), permanent: true);
    
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
                key: _formKey,
                child: Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColor.blue900,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormFieldWidget(hintText: 'Email address', icon: Icons.email, textController: InputControllers.signInEmailController, validate: Validator.validateEmail),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('A password reset link will be sent to you on the email address you provide above.'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        child: Center(
                          child: Obx(() => ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.85, 50.0)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                ),
                                backgroundColor: forgotPasswordPageController.isButtonDisabled.value ? MaterialStateProperty.all(AppColor.blue100) : MaterialStateProperty.all(AppColor.blue900),
                                foregroundColor: MaterialStateProperty.all(AppColor.white),
                              ),
                              onPressed: forgotPasswordPageController.isButtonDisabled.value? null : () async {
                                bool check = _formKey.currentState!.validate();
                                if (check) {
                                  Get.dialog(
                                    Center(
                                      child: SpinKitCircle(
                                        color: AppColor.blue900,
                                        size: 70.0,
                                      ),
                                    ),
                                  );
                                  try {
                                    await Auth().passwordReset(email: InputControllers.signInEmailController.text.trim());
                                    Get.back();
                                    Get.snackbar(
                                      'Email sent!',
                                      'Click on the password reset link and change the password.',
                                      colorText: AppColor.black,
                                      backgroundColor: AppColor.blue100,
                                      icon: Icon(Icons.task_alt),
                                      duration: Duration(seconds: 3),
                                    );
                                    forgotPasswordPageController.startTimer();
                                    InputControllers.signInEmailController.clear();
                                  } catch (e) {
                                    print('Error adding employee: $e');
                                    Get.back();
                                    Get.snackbar(
                                      'Error sending email!',
                                      'Please try again after few minutes.',
                                      colorText: AppColor.black,
                                      backgroundColor: AppColor.red100,
                                      icon: Icon(Icons.error),
                                      duration: Duration(seconds: 3),
                                    );
                                  }
                                }
                              },
                              child: Text('Send',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      forgotPasswordPageController.isButtonDisabled.value? Obx(() => Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text('Resend the email after ${forgotPasswordPageController.seconds.value} seconds',
                            style: TextStyle(
                              color: AppColor.grey600,
                            ),
                          ),
                      ),
                      ) : Text(''),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
