import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blue50,
        appBar: AppBar(
          foregroundColor: AppColor.white,
          backgroundColor: AppColor.blue900,
          title: Text('About',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          toolbarHeight: 65.0,
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('Welcome to our WorkForce Optics App, a comprehensive solution designed to streamline and enhance workforce administration for businesses of all sizes. \n\nBuilt with Flutter and integrated with Firebase, our app offers robust features such as user authentication, leave management, task assignment, and event scheduling. \nAdministrators can efficiently manage employee records, monitor attendance, and approve leave requests, while employees have access to their profiles, tasks, and performance reports.\n\nThe intuitive interface ensures a seamless user experience, promoting effective communication and coordination within your organization.\nWith real-time updates and secure data storage, our app is dedicated to improving operational efficiency and fostering a productive work environment. \n\nThank you for choosing our WorkForce Optics App!',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
