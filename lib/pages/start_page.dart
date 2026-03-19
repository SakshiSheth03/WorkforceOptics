import 'package:flutter/material.dart';
import 'package:hrms_system/common_widgets/elevated_button.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_colors.dart';

class StartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.0,),
                Lottie.asset('assets/animations/team.json',
                  height: 200.0,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('WorkForce',
                        style: TextStyle(
                          color: AppColor.blue900,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 7.0,),
                      Text('Optics',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                    child: Text('Streamline HR Management effortlessly, simplify your workday.',
                      textAlign: TextAlign.center,
                    ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  margin: EdgeInsets.all(40.0),
                  child: ElevatedButtonWidget(context: context, buttonText: 'Sign In', nextRoute: '/signInPage'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
