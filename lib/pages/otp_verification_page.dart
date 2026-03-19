import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../common_widgets/elevated_button.dart';
import '../utils/app_colors.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({super.key});

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verification',
                    style: TextStyle(
                      color: AppColor.blue900,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Enter the verification code that we just sent to your email address'),
                  OtpTextField(
                    margin: EdgeInsets.only(right: 8.0, top: 15.0),
                    numberOfFields: 5,
                    borderColor: AppColor.blue900,
                    focusedBorderColor: AppColor.blue900,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    fieldWidth: 52.0,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    textStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Verification Code"),
                              content: Text('Code entered is $verificationCode'),
                            );
                          }
                      );
                    }, // end onSubmit
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: ElevatedButtonWidget(context: context, buttonText: 'Verify', nextRoute: '/dashboard'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget MyTextField(context, TextEditingController _controller) {
//   return Container(
//     width: 40,
//     height: 60,
//     margin: EdgeInsets.only(left: 10, top: 20.0, bottom: 20.0),
//     child: TextField(
//       keyboardType: TextInputType.number,
//       textAlign: TextAlign.center,
//       maxLength: 1,
//       style: TextStyle(
//         fontSize: 20.0,
//       ),
//       decoration: InputDecoration(
//         counterText: '',
//         // fillColor: Colors.blue,
//         // filled: true,
//       ),
//       onChanged: (value) {
//         print("************************************************************************$value");
//         print("************************************************************************${value.runtimeType}");
//         print("************************************************************************${value.length}");
//         if(value.length == 1) {
//           FocusScope.of(context).nextFocus();
//         }
//         if(value.length == 0) {
//           FocusScope.of(context).previousFocus();
//         }
//       },
//     ),
//   );
// }

