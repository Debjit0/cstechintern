import 'package:cstechintern/model/device_model.dart';
import 'package:cstechintern/services/api_service.dart';
import 'package:cstechintern/services/appinfo_service.dart';
import 'package:cstechintern/services/device_service.dart';
import 'package:cstechintern/services/location_service.dart';
import 'package:cstechintern/services/network_service.dart';
import 'package:cstechintern/services/storage_service.dart';
import 'package:cstechintern/view/home_screen.dart';
import 'package:cstechintern/view/login_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var deviceInfo = Rxn<DeviceModel>();
  final _apiService = ApiService();
  @override
  void onInit() {
    super.onInit();
    fetchDeviceData();
  }

  Future<void> fetchDeviceData() async {
    var device = await DeviceService.getDeviceInfo();
    var ipAddress = await NetworkService.getIPAddress();
    var location = await LocationService.getLocation();
    var appVersion = await AppService.getAppVersion();

    deviceInfo.value = DeviceModel(
      deviceType: device["deviceType"]!,
      deviceId: device["deviceId"]!,
      deviceName: device["deviceName"]!,
      deviceOSVersion: device["deviceOSVersion"]!,
      deviceIPAddress: ipAddress,
      latitude: location["latitude"]!,
      longitude: location["longitude"]!,
      buyerGcmId: "",
      appVersion: appVersion,
    );

    Map<String, dynamic> deviceData = {
      "deviceType": deviceInfo.value!.deviceType,
      "deviceId": deviceInfo.value!.deviceId,
      "deviceName": deviceInfo.value!.deviceName,
      "deviceOSVersion": deviceInfo.value!.deviceOSVersion,
      "deviceIPAddress": deviceInfo.value!.deviceIPAddress,
      "lat": deviceInfo.value!.latitude,
      "long": deviceInfo.value!.longitude,
      "buyer_gcmid": "",
      "buyer_pemid": "",
      "app": {
        "version": deviceInfo.value!.appVersion,
        "installTimeStamp": DateTime.now().toIso8601String(),
        "uninstallTimeStamp": "",
        "downloadTimeStamp": DateTime.now().toIso8601String(),
      }
    };
    //print("called splash api");
    await _apiService.splashApi(deviceData);
    String? deviceId = await StorageService.getDeviceId();
    bool? isLoggedIn = await StorageService.getIsLoggedIn();
    String? userId = await StorageService.getUserId();

    if (userId == null || deviceId == null || isLoggedIn == false) {
      print("pushed login");
      Get.offAll(() => LoginScreen());
    } else if (isLoggedIn == true) {
      print("pushed home");
      Get.offAll(() => MainScreen());
    }
  }
}
