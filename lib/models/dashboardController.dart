import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/pages/home_page_admin.dart';
import '../pages/calendar_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class DashboardController extends GetxController{
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

  // the selected index variable is for the page selected from bottom navigation bar
  final selectedIndex = 0.obs;

  // list of widgets to return when a particular page is selected from bottom navigation bar
  List<Widget> pages = [
    HomePage(),
    CalendarPage(),
    ProfilePage(),
  ];

  // list of widgets to return when a particular page is selected from bottom navigation bar but only for admin
  List<Widget> adminPages = [
    HomePageAdmin(),
    CalendarPage(),
    ProfilePage(),
  ];

  // method navigateBottomBar: When the tab is changed the selectedIndex needs to be updated
  void navigateBottomBar(int index) {
    selectedIndex.value = index;
  }
}