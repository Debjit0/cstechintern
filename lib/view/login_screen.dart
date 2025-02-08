import 'package:cstechintern/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/logo.jpeg"),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Glad to see you", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Please provide your phone number", style: TextStyle(fontSize: 18, color: Colors.grey), ),
            SizedBox(height: 60,),
                ],
              ),
            ),
            
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            SizedBox(height: 20),
            Obx(() {
              return controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          String mobile = mobileController.text.trim();
                          if (mobile.length == 10) {
                            controller.sendOtp(mobile);
                          } else {
                            Get.snackbar("Invalid", "Enter a valid phone number");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 215, 78, 68), // Button color
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Button size
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Rounded corners
                                  ),
                                ),
                        child: Text("Send OTP", style: TextStyle(color: Colors.white),),
                      ),
                  );
            }),
          ],
        ),
      ),
    );
  }
}
