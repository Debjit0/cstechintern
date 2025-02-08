import 'package:cstechintern/model/user_model.dart';
import 'package:cstechintern/services/api-service.dart';
import 'package:get/get.dart';
import '../view/otp_screen.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = false.obs;

  Future<void> sendOtp(String mobileNumber) async {
    isLoading.value = true;
    UserModel? user = await _apiService.sendOtp(mobileNumber);
    isLoading.value = false;

    if (user != null) {
      Get.to(()=>OtpScreen());
    } else {
      Get.snackbar("Error", "Failed to send OTP. Try again.");
    }
  }
}