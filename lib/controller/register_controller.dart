import 'package:cstechintern/services/api-service.dart';
import 'package:cstechintern/services/storage_service.dart';
import 'package:cstechintern/view/home_screen.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final ApiService _apiService = ApiService();
  var isRegistering = false.obs;

  Future<void> registerUser(
      String email, String password, String? referralCode) async {
    isRegistering.value = true;
    bool success =
        await _apiService.registerUser(email, password, referralCode);
    isRegistering.value = false;

    if (success) {
      await StorageService.setIsLoggedIn(true);
      Get.offAll(() => MainScreen());
    } else {
      Get.snackbar("Error", "Registration failed. Try again.");
    }
  }
}
