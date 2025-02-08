import 'dart:async';

import 'package:cstechintern/services/api-service.dart';
import 'package:cstechintern/view/home_screen.dart';
import 'package:cstechintern/view/registration_screen.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final ApiService _apiService = ApiService();
  var isVerifying = false.obs;

  RxInt secondsRemaining = 90.obs;  // 1 min 30 sec
  RxBool isResendEnabled = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    isResendEnabled.value = false;
    secondsRemaining.value = 90;  // Reset to 1 min 30 sec

    _timer?.cancel();  // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    startTimer();  // Restart the timer
    // Call API to resend OTP
    print("Resending OTP...");
  }

  @override
  void onClose() {
    _timer?.cancel();  // Stop timer when screen is closed
    super.onClose();
  }

  Future<void> verifyOtp(String otp) async {
    isVerifying.value = true;
    Map<String, dynamic>? response = await _apiService.verifyOtp(otp);
    isVerifying.value = false;

    if (response != null) {
      String registrationStatus = response["registration_status"];

      if (registrationStatus == "Incomplete") {
        Get.to(() => RegisterScreen());
      } else {
        Get.offAll(()=>MainScreen());
      }
    } else {
      Get.snackbar("Error", "Invalid OTP. Try again.");
    }
  }
}
