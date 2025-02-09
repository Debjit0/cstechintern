import 'package:cstechintern/constants/url.dart';
import 'package:cstechintern/model/user_model.dart';
import 'package:cstechintern/services/storage_service.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  String _otpVerifyUrl = "${base}/user/otp/verification";
  String _otpUrl = "${base}/user/otp";
  String _registerUrl = "${base}/user/email/referral";

  Future<void> splashApi(Map<String, dynamic> deviceData) async {
    String url = "${base}/v2/user/device/add";

    try {
      Response response = await _dio.post(
        url,
        data: deviceData,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 && response.data["status"] == 1) {
        String deviceId = response.data["data"]["deviceId"];
        await StorageService.saveDeviceId(deviceId);
        String? devId = await StorageService.getDeviceId();
        print("Device ID saved: ${devId}");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("API Error: $e");
    }
  }

  Future<UserModel?> sendOtp(String mobileNumber) async {
    String? savedDeviceId = await StorageService.getDeviceId();
    if (savedDeviceId == null) {
      print("No device ID found.");
      return null;
    }

    try {
      Response response = await _dio.post(
        _otpUrl,
        data: {
          "mobileNumber": mobileNumber,
          "deviceId": savedDeviceId,
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print(response.data);

      if (response.statusCode == 200 && response.data["status"] == 1) {
        String userId = response.data["data"]["userId"];
        String deviceId = response.data["data"]["deviceId"];

        UserModel user = UserModel(userId: userId, deviceId: deviceId);
        await StorageService.saveUserId(userId);

        return user;
      } else {
        print("OTP request failed: ${response.data}");
        return null;
      }
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> verifyOtp(String otp) async {
    String? deviceId = await StorageService.getDeviceId();
    String? userId = await StorageService.getUserId();
    print("User Id is : $userId");

    if (deviceId == null || userId == null) {
      print("Missing deviceId or userId");
      return null;
    }

    try {
      Response response = await _dio.post(
        _otpVerifyUrl,
        data: {
          "otp": otp,
          "deviceId": deviceId,
          "userId": userId,
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 && response.data["status"] == 1) {
        return response.data["data"];
      } else {
        print("OTP verification failed: ${response.data}");
        return null;
      }
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }

  Future<bool> registerUser(
      String email, String password, String? referralCode) async {
    String? userId = await StorageService.getUserId();
    if (userId == null) {
      print("User ID is missing");
      return false;
    }

    try {
      Response response = await _dio.post(
        _registerUrl,
        data: {
          "email": email,
          "password": password,
          "referralCode": referralCode?.isEmpty == true ? null : referralCode,
          "userId": userId,
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 && response.data["status"] == 1) {
        return true;
      } else {
        print("Registration failed: ${response.data}");
        return false;
      }
    } catch (e) {
      print("API Error: $e");
      return false;
    }
  }
}
