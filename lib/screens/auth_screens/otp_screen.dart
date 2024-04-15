import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constant/app_preferences.dart';
import '../../constant/constant.dart';
import '../../models/verify_otp_model.dart';
import '../../services/login_with_phone.dart';
import '../bottom_nav_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff300030),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffFFFFFF),
            size: 15,
          ),
          onPressed: () {
            Navigator.pop(context); // Handles navigation to previous route
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "OTP Verification",
          style: TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "we have sent a verification code to",
              style: TextStyle(fontSize: 15, color: Color(0xffABABAB)),
            ),
            Text(
              "8448686292",
              style: TextStyle(fontSize: 15, color: Color(0xffE5E3E3)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              textAlign: TextAlign.center,
              "we have sent one time password (OTP) to the mobile number above . please enter it to complete verification .",
              style: TextStyle(fontSize: 12, color: Color(0xffFFFFFF)),
            ),
            const SizedBox(height: 20),
            OtpTextField(
              autoFocus: true,
              numberOfFields: 4,
              fieldWidth: 50,
              fillColor: Color(0xffFEFEFE),
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
              margin: const EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(15),
              cursorColor: Colors.white,
              enabledBorderColor: Color(0xffFEFEFE).withOpacity(0.5),
              disabledBorderColor: Colors.pink,
              showCursor: true,
              showFieldAsBox: true,
              keyboardType: TextInputType.phone,
              onCodeChanged: (String code) {
                print("OTP $code");
                //handle validation or checks here
              },
              onSubmit: (String verifyController) async {
                print("OTP $verifyController");
                try {
                  await verifyOTP(verifyController);
                } catch (e) {
                  print(e);
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Resend OTP",
              style: TextStyle(fontSize: 16, color: Color(0xff9D04C3)),
            ),
          ],
        ),
      ),
    );
  }

  verifyOTP(String otp) async {
    try {
      if (otp.isEmpty) {
        //showMessageDialog("Please enter verification code", false, context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter verification code"),
        ));
      } else if (otp.length != 4) {
        // showMessageDialog(
        //     "Verification code must have 4 digits", false, context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Verification code must have 4 digits"),
        ));
      } else {
         EasyLoading.show();
        await LoginServicesPhone()
            .verifyOtp(otp, MyConstant.mobileNumber)
            .then((value) {
           EasyLoading.dismiss();
          print("check error ${value.error}");
          if (value.status == true) {
            print("opt_response: ${value.status}");
            VerifyOtpModel data = value.data;
            print("id g user: ${data}");
            PreferencesApp().setAccessToken(data.token ?? "");
            MyConstant.access_token = data.token ?? "";
            PreferencesApp().setIsNewUser(true);
            print("--------token ${MyConstant.access_token}");
            // sharedPreferences?.setBool("isLoggedIn", true);
            // sharedPreferences?.setString("userID", data.data!.id!.toString());
            // sharedPreferences?.setString("token", data.token.toString());

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar(currentIndex: 0,)),
                (route) => false);
             EasyLoading.dismiss();
          } else {
            print("Invalid OTP response");
            // EasyLoading.dismiss();
            // showMessageDialog(value.error ?? "", false, context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Invalid OTP "),
            ));
          }
        });
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("$e");
      // TODO
    }
  }
}
