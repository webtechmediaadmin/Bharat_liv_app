import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constant/constant.dart';
import '../../models/login_model.dart';
import '../../services/login_with_phone.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async {
        // Prevent user from going back
        SystemNavigator.pop();
        return true; // Returning false will prevent the default back navigation
      },
      child: Scaffold(
        backgroundColor: const Color(0xff300030),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/bg.png",
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/bg1.png",
                ),
              ),
              Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xff000000).withOpacity(0.5),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffE5E3E3).withOpacity(0.15),
                          border: Border.all(
                            color: const Color(0xffFEFEFE).withOpacity(0.5),
                          ),
                        ),
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            FilteringTextInputFormatter.allow(RegExp(
                                r'^[+]*[(]{0,1}[6-9]{1,4}[)]{0,1}[-\s\./0-9]*$')),
                          ],
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
    
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '+91',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            hintText: 'Enter your mobile number',
                            hintStyle: TextStyle(
                              color: Color(0xffE5E3E3),
                              fontSize: 14,
    
                              // Adjust the font size
                            ),
                            hintMaxLines: 1, // Ensure single line
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                           try {
                            await loginUser(phoneController.text.trim().toString());
                           } catch (e) {
                             print(e); 
                           }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE5E3E3),
                          ),
                          child: const Center(
                            child: Text(
                              "GET OTP",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        " term of service    privacy policy",
                        style: TextStyle(
                          color: Color(0xffF5F5F5).withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginUser(String mobileNumber) {
    final mobileValidation = isValidPhoneNumber(mobileNumber);
    if (mobileNumber == "") {
      //showMessageDialog("Please enter mobile number", false, context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter mobile number"),
      ));
    } else if (mobileNumber.length < 10) {
      // showMessageDialog("Mobile number must have 10 digits", false, context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Mobile number must have 10 digits"),
      ));
    } else if (mobileValidation == false) {
      // showMessageDialog("Invalid mobile number", false, context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid mobile number"),
      ));
    } else {
      // isLoading.value = true;
     EasyLoading.show(
      
     );
      LoginServicesPhone().loginUser(mobileNumber).then((value) async {
        if (value.status == true) {
          LoginPhoneModel data = value.data as LoginPhoneModel;
          print("------------%%%%%%%%");
          print(data.otp);
          MyConstant.mobileNumber = mobileNumber;
         
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OTPScreen(),
            ),
          );

          // isLoading.value = false;
         EasyLoading.dismiss();
        } else {
          EasyLoading.dismiss();
          // isLoading.value = false;
          //  showMessageDialog(value.error!, false, context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong"),
          ));
        }
      }).catchError((error) {
        //isLoading.value = false;
        EasyLoading.dismiss();
        Future.delayed(const Duration(seconds: 5), () {
          Timer(const Duration(seconds: 10), () {
            if (mounted) {
              EasyLoading.dismiss();
              //showMessageDialog("Api is not responding", false, context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Api is not responding ${error}"),
              ));
            }
          });
        });
      });
    }
  }
}
