import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String buttonText;
  final String nextRoute;

  const ElevatedButtonWidget({
    super.key,
    context,
    required this.buttonText,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.85, 50.0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(AppColor.blue900),
        foregroundColor: MaterialStateProperty.all(AppColor.white),
      ),
      onPressed: () async {
        if (buttonText == 'Sign In') {
          Get.toNamed(nextRoute);
        }
      },
      child: Text(buttonText,
        style: TextStyle(
          color: AppColor.white,
        ),
      ),
    );
  }
}
