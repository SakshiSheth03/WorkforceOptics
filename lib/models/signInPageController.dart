import 'package:get/get.dart';
class SignInPageController extends GetxController{
  @override
  void onInit(){
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady(){
    // Get called after widget is rendered on the screen
    super.onReady();
  }

  @override
  void onClose(){
    //Get called when controller is removed from memory
    super.onClose();
  }

  // List<String> roles that appears in the drop down button for select your role
  List<String> roles = ['Admin', 'Employee'].obs;

  // selected value of role for the drop down button for select your role
  RxString selectedValue = 'Employee'.obs;

  // change the selected value of the drop down button
  void changeDropDownSelectedValue(String value) {
    selectedValue.value = value;
  }

  // bool variable to hide and unhide the password
  final passwordHidden = true.obs;

  // TextEditingController for email id of user
  // final emailController = TextEditingController().obs;

  // TextEditingController for password user
  // final passwordController = TextEditingController().obs;

  // error message from firebase authentication
  final errorMessage = ''.obs;
}