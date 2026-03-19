import 'package:get/get.dart';

class CurrentUserInfo extends GetxController{
  static final empName = ''.obs;
  static RxInt empID = 0.obs;
  static Rx<DateTime> empDOB = DateTime.now().obs;
  static RxString empEmail = ''.obs;
  static RxInt empPhNum = 0.obs;
  static RxString empBldGrp = ''.obs;
  static RxString empAdd = ''.obs;
  static RxString empNationality = ''.obs;
  static RxString empLang = ''.obs;
  static RxString empJobTitle = ''.obs;
  static RxString empDept = ''.obs;
  static Rx<DateTime> empStartDate = DateTime.now().obs;
  static RxString empStatus = ''.obs; //full-time, part-time
  static RxDouble empPerformanceRatings = 0.0.obs;
  static RxString empAchievements = ''.obs;
  static RxString role = ''.obs;
  static RxString profileImageUrl = ''.obs;
}