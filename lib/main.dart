import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hrms_system/pages/about_page.dart';
import 'package:hrms_system/pages/add_employee_page.dart';
import 'package:hrms_system/pages/assign_task_page.dart';
import 'package:hrms_system/pages/birthdays_page.dart';
import 'package:hrms_system/pages/dashboard.dart';
import 'package:hrms_system/pages/departments_employees.dart';
import 'package:hrms_system/pages/festivals_page.dart';
import 'package:hrms_system/pages/forgot_password_page.dart';
import 'package:hrms_system/pages/leave_page.dart';
import 'package:hrms_system/pages/leave_page_admin.dart';
import 'package:hrms_system/pages/loading.dart';
import 'package:hrms_system/pages/request_leave_page.dart';
import 'package:hrms_system/pages/start_page.dart';
import 'package:get/get.dart';
import 'package:hrms_system/pages/otp_verification_page.dart';
import 'package:hrms_system/pages/tasks_page.dart';
import 'package:hrms_system/pages/team_page.dart';
import 'package:hrms_system/pages/work_report_page.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:hrms_system/models/my_controller.dart';
import '../pages/signin_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // init the firebase
  await Firebase.initializeApp();

  MyController getXController = Get.put(MyController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppColor.blue900,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.blue900),
          primaryColor: AppColor.blue900,
          brightness: Brightness.light,
      ),
      title: 'GetX Routing Demo',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => StartPage()),
        GetPage(name: '/signInPage', page: () => LoginPage()),
        GetPage(name: '/forgotPasswordPage', page: () => ForgotPasswordPage()),
        GetPage(name: '/otpVerificationPage', page: () => VerificationPage()),
        GetPage(name: '/loading', page: () => Loading()),
        GetPage(name: '/dashboard', page: () => Dashboard()),
        GetPage(name: '/taskPage', page: () => TasksPage()),
        GetPage(name: '/deptEmpPage', page: () => DepartmentsEmployees()),
        GetPage(name: '/leavePage', page: () => LeavePage()),
        GetPage(name: '/addEmployeePage', page: () => AddEmployeePage()),
        GetPage(name: '/requestLeavePage', page: () => RequestLeavePage()),
        GetPage(name: '/leavePageAdmin', page: () => LeavePageAdmin(isLeavePage: true,)),
        GetPage(name: '/taskPageAdmin', page: () => LeavePageAdmin(isLeavePage: false,)),
        GetPage(name: '/teamPage', page: () => TeamPage()),
        GetPage(name: '/workReportPage', page: () => WorkReportPage()),
        GetPage(name: '/assignTaskPage', page: () => AssignTaskPage()),
        GetPage(name: '/festivalsPage', page: () => FestivalsPage()),
        GetPage(name: '/birthdaysPage', page: () => BirthDatesPage()),
        GetPage(name: '/aboutPage', page: () => AboutPage()),
      ],
    );
  }
}
