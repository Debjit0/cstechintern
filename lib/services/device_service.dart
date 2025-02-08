import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static Future<Map<String, String>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceType = Platform.isAndroid ? "Android" : "iOS";
    String deviceId = "Unknown";
    String deviceName = "Unknown";
    String deviceOSVersion = "Unknown";

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      deviceName = androidInfo.model;
      deviceOSVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "Unknown";
      deviceName = iosInfo.utsname.machine;
      deviceOSVersion = iosInfo.systemVersion;
    }

    return {
      "deviceType": deviceType,
      "deviceId": deviceId,
      "deviceName": deviceName,
      "deviceOSVersion": deviceOSVersion,
    };
  }
}