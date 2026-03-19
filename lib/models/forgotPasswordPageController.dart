import 'dart:async';
import 'package:get/get.dart';
class ForgotPasswordPageController extends GetxController{
  static const maxSeconds = 90;
  final seconds = maxSeconds.obs;
  final isButtonDisabled = false.obs;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    // Restore the state if needed, e.g., from storage
  }

  void startTimer() {
    isButtonDisabled.value = true;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      seconds.value--;
      if (seconds.value <= 0) {
        timer?.cancel();
        isButtonDisabled.value = false;
        seconds.value = maxSeconds;
      }
    });
  }

  @override
  void onClose() {
    // Do not cancel the timer here to keep it running even when the controller is disposed
  }
}