import 'dart:async';
import 'package:get/get.dart';

class HomePageController extends GetxController{

  DateTime toadyTime = DateTime.now();
  Timer? timer;
  final time = "00:00:00".obs;
  final percent = 0.0.obs;
  final overtime = "...".obs;
  // final hours = 0.obs, minutes = 0.obs, seconds=0.obs;

  startTimer() {
    DateTime checkInTime = DateTime(toadyTime.year, toadyTime.month, toadyTime.day, 9, 28, 3, 0, 0);
    DateTime shiftOverTime = checkInTime.add(Duration(seconds: 28800));
    Duration diffDuration1 = toadyTime.difference(checkInTime);
    Duration diffDuration2 = toadyTime.difference(shiftOverTime);
    int remainingTime = (28800 - diffDuration1.inSeconds);
    int remainingOverTime = (14400 - diffDuration2.inSeconds);
    print("--------------------------------------------------------------------------------------------------");
    print(checkInTime);
    print(shiftOverTime);
    print(diffDuration1);
    print(diffDuration2);
    print(remainingTime);
    print(remainingOverTime);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(remainingTime == 0) {
        timer.cancel();
      } else {
        if(diffDuration1.inSeconds>0 && diffDuration1.inSeconds<28800 && remainingTime>0) {
          overtime.value = "...";
          toadyTime = DateTime.now();
          diffDuration1 = toadyTime.difference(checkInTime);
          remainingTime--;
          percent.value = (28800-remainingTime)*100/28800;
          time.value = diffDuration1.inHours.toString() + ":" + ((diffDuration1.inMinutes%60)%60).toString().padLeft(2, "0") + ":" + ((diffDuration1.inSeconds%3600)%60).toString().padLeft(2,"0");
        } else if(diffDuration2.inSeconds >0 && diffDuration1.inSeconds >=28800 && diffDuration2.inSeconds<14400){
          toadyTime = DateTime.now();
          diffDuration2 = toadyTime.difference(shiftOverTime);
          remainingOverTime--;
          percent.value = (14400-remainingOverTime)*100/14400;
          time.value = diffDuration2.inHours.toString() + ":" + ((diffDuration2.inMinutes%60)%60).toString().padLeft(2, "0") + ":" + ((diffDuration2.inSeconds%3600)%60).toString().padLeft(2,"0");
          overtime.value = time.value;
        } else {
          percent.value = 0.0;
          time.value = "00:00:00";
          overtime.value = "...";
        }
      }
    });
  }

  @override
  void onInit(){
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady(){
    // Get called after widget is rendered on the screen
    super.onReady();
    startTimer();
  }

  @override
  void onClose(){
    //Get called when controller is removed from memory
    super.onClose();
  }
}