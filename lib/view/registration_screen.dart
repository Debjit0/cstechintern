import 'package:cstechintern/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.jpeg"),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Begin",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter your credentials to proceed.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: referralController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: "Referral Code (Optional)"),
            ),
            SizedBox(height: 20),
            // Obx(() {
            //   return controller.isRegistering.value
            //       ? CircularProgressIndicator()
            //       : ElevatedButton(
            //           onPressed: () {
            //             String email = emailController.text.trim();
            //             String password = passwordController.text.trim();
            //             String referral = referralController.text.trim();

            //             if (email.isNotEmpty && password.isNotEmpty) {
            //               controller.registerUser(email, password, referral);
            //             } else {
            //               Get.snackbar(
            //                   "Error", "Email and password are required");
            //             }
            //           },
            //           child: Text("Register"),
            //         );
            // }),
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
      onPressed: () {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
        String referral = referralController.text.trim();

        if (email.isNotEmpty && password.isNotEmpty) {
          controller.registerUser(email, password, referral);
        } else {
          Get.snackbar("Error", "Email and password are required");
        }
      },
      backgroundColor: Color.fromARGB(255, 215, 78, 68),
      child: controller.isRegistering.value
          ? CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            )
          : Icon(Icons.arrow_right, size: 28, color: Colors.white),
    )),

    );
  }
}
