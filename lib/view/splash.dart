import 'package:cstechintern/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          if (controller.deviceInfo.value == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Image.asset('assets/logo.jpeg'),
              ],
            );
          }
          //final device = controller.deviceInfo.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.jpeg'),
              // Text("Device Name: ${device?.deviceName}"),
              // Text("OS Version: ${device?.deviceOSVersion}"),
              // Text("IP Address: ${device?.deviceIPAddress}"),
              // Text("Latitude: ${device?.latitude}, Longitude: ${device?.longitude}"),
              // Text("App Version: ${device?.appVersion}"),
            ],
          );
        }),
      ),
    );
  }
}
