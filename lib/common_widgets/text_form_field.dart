import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/signInPageController.dart';
import '../utils/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  String? Function(String?) validate;

  TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textController,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {

    SignInPageController getXController = Get.put(SignInPageController());

    return Obx(() {
      bool isPasswordHidden = getXController.passwordHidden.value;
      return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validate,
        controller: textController,
        obscureText: hintText == 'Password'? isPasswordHidden: false,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: AppColor.blue50,
          filled: true,
          prefixIcon: Icon(icon),
          suffixIcon: hintText == 'Password'? Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(isPasswordHidden
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                getXController.passwordHidden.value = !getXController.passwordHidden.value;
              },
            ),
          ) : null,
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.blue.shade900, width: 0.8),
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25.0),
          ),
          border: OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.blue.shade900, width: 0.8),
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),

      );
    }
    );
  }
}
