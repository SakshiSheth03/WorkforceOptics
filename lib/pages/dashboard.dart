import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/models/auth.dart';
import 'package:hrms_system/models/dashboardController.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../models/signInPageController.dart';
import '../utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final User? user = Auth().currentUser;
  // access the user email with user?.email

  DashboardController dashboardController = Get.put(DashboardController());
  SignInPageController signInPageController = Get.put(SignInPageController());

  @override
  Widget build(BuildContext context) {
    String role = signInPageController.selectedValue.value;
    return SafeArea(
      child: Obx( () =>
        Scaffold(
          appBar: dashboardController.selectedIndex.value == 0 ? AppBar(
            backgroundColor: AppColor.blue900,
            title: Text('Dashboard',
              style: TextStyle(
                color: AppColor.white,
              ),
            ),
            toolbarHeight: 65.0,
            iconTheme: IconThemeData(
              color: AppColor.white,
            ),
          ) : null,
          drawer: MyNavigationDrawer(),
          body: role == 'Admin'? dashboardController.adminPages[dashboardController.selectedIndex.value] :dashboardController.pages[dashboardController.selectedIndex.value],
          bottomNavigationBar: BottomNavBar(
            onTabChange: (index) => dashboardController.navigateBottomBar(index),
          ),
        ),
      ),
    );
  }
}

// Bottom Navigation Bar Widget
Widget BottomNavBar({Function(int)? onTabChange}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.blue50,
    ),
    padding: EdgeInsets.symmetric(vertical: 0.0),
    child: GNav(
        onTabChange: (value) => onTabChange!(value),
        backgroundColor: AppColor.blue900,
        padding: EdgeInsets.all(15),
        tabMargin: EdgeInsets.all(7),
        color: AppColor.white,
        activeColor: AppColor.blue900,
        tabBackgroundColor: AppColor.blue50,
        tabBorderRadius: 10,
        // tabActiveBorder: Border.all(color: AppColor.white),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.calendar_month_rounded,
            text: 'Calendar',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ]
    ),
  );
}

class MyNavigationDrawer extends StatelessWidget {

  MyNavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.blueDrawer,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    color: AppColor.transparent,
    padding: EdgeInsets.only(top: 30.0),
    child: Column(
      children: [
        Image.asset('assets/images/team2.png'),
        Row(
          children: [
            SizedBox(width: 20.0,),
            Text('WorkForce',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24.0,
                color: AppColor.blue900,
              ),
            ),
            Text(' Optics',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24.0,
                color: AppColor.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildMenuItems(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height - 300.0,
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.home,
                color: AppColor.blue900,
              ),
              title: Text("Home",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: AppColor.blue900,
                ),
              ),
              onTap: () {
                // Navigate to home page
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_rounded,
                color: AppColor.blue900,
              ),
              title: Text("About",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: AppColor.blue900,
                ),
              ),
              onTap: () {
                // close navigation drawer before
                Navigator.pop(context);
                // Navigate to about page
                Get.toNamed('aboutPage');
              },
            ),
          ],
        ),
        // SizedBox(height: 200.0,),
        ListTile(
          leading: Icon(Icons.logout,
            color: AppColor.blue900,
          ),
          title: Text("Sign Out",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              color: AppColor.blue900,
            ),
          ),
          onTap: () async {
            await Auth().signOut();
            Get.offAllNamed('/signInPage');
          },
        )
      ],
    ),
  );
}
