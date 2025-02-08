import 'package:cstechintern/controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final OtpController controller = Get.put(OtpController());
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 150, child: Image.asset("assets/otp.png")),
            SizedBox(height: 40),
            Text(
              "OTP Verification",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Please provide the otp sent to your number",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 60),
            
            // OTP Text Field
            OtpTextField(
              numberOfFields: 4,
              fieldWidth: MediaQuery.of(context).size.width / 7,
              borderColor: Colors.red,
              focusedBorderColor: Colors.red,
              showFieldAsBox: true,
              onSubmit: (otp) => controller.verifyOtp(otp),  // Call verifyOtp on complete input
            ),
            SizedBox(height: 20),

            // Obx(() {
            //   return controller.isVerifying.value
            //       ? Center(child: CircularProgressIndicator())
            //       : ElevatedButton(
            //           onPressed: () {
            //             // No need to fetch text, it gets passed in onSubmit
            //           },
            //           child: Text("Verify OTP"),
            //         );
            // }),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                      "Resend OTP in ${controller.secondsRemaining.value}s",
                    )),
                SizedBox(height: 20),
                Obx(() => TextButton(
                      onPressed: controller.isResendEnabled.value
                          ? () => controller.resendOtp()
                          : null,
                      child: Text("Resend OTP"),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
