
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:livetv2024/app/widgets/snackbar.dart';

import '../../constant/color.dart';
import '../../constant/text.dart';
import '../../widgets/button.dart';
import 'otp2.dart';


class SignInOrSignUpWithPhone extends StatefulWidget {
  const SignInOrSignUpWithPhone({super.key});

  @override
  State<SignInOrSignUpWithPhone> createState() => _SignInOrSignUpWithPhoneState();
}

class _SignInOrSignUpWithPhoneState extends State<SignInOrSignUpWithPhone> {
  TextEditingController phoneNumberController = TextEditingController();
  bool acceptTerms = true;
  bool isSendingOTP = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              150.verticalSpace,
              Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png',
                          height: 24, width: 98),
                      16.verticalSpace,
                      const Text('Enter Your Mobile Number to Login',style: AppTextStyle.grey20w600,),
                    ],
                  )),
              24.verticalSpace,
              Text(
                "We will send you a verification code!",
                style: AppTextStyle.purple16w500,
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColor.pink), borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   15.horizontalSpace,
                    const Text(
                      "+88",
                      style: AppTextStyle.purple16w500,
                    ),
                    15.horizontalSpace,
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: AppColor.pink),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: TextField(
                        style: AppTextStyle.purple16w500,
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your Phone No.",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              16.verticalSpace,
              Row(
                children: [
                  Checkbox(
                    activeColor: AppColor.pink,
                    value: acceptTerms,
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          acceptTerms = value ?? true;
                        });
                      }
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'I accept the ',
                      style: AppTextStyle.grey14w500,
                      children: [
                        TextSpan(
                          text: 'Terms of Use',
                          style:  AppTextStyle.purple14w600,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Terms of Use page
                              // Navigator.pushNamed(context, '/terms');
                            },
                        ),
                        const TextSpan(
                          text: ' & ',
                          style: AppTextStyle.grey14w500,
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: AppTextStyle.purple14w600,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Privacy Policy page
                              // Navigator.pushNamed(context, '/privacy');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              CustomButton(
                title: 'login'.tr,
                //color: AppColor.teal,
                gradient: AppColor.gradient,
                onTap: isSendingOTP
                    ? null
                    : () async {
                  String phoneNumber = phoneNumberController.text.trim();

                  // Validate the phone number and acceptance of terms
                  if (_validatePhoneNumber(phoneNumber) && acceptTerms) {
                    if (mounted) {
                      setState(() {
                        isSendingOTP = true;
                      });
                    }

                    // Send OTP
                    String? generatedOtp = await sendOtp(phoneNumber);

                    if (mounted) {
                      setState(() {
                        isSendingOTP = false;
                      });
                    }

                    if (generatedOtp != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyOtpScreen(generatedOtp, phoneNumber),
                        ),
                      );
                    } else {
                      CustomSnackBar.showSnackBar(title: 'Failed', message: 'Failed to send OTP',color: Colors.red);
                    }
                  } else {
                    // Phone number or terms acceptance is not valid
                    if (!_validatePhoneNumber(phoneNumber)) {
                      CustomSnackBar.showSnackBar(title: 'Failed', message: 'Invalided mobile number',color: Colors.red);
                    }
                    if (!acceptTerms) {
                      CustomSnackBar.showSnackBar(title: 'Failed', message: 'Accept Terms of Use and Privacy Policy',color: Colors.red);
                    }
                  }
                },
              ),
              // SizedBox(
              //   height: 45,
              //   // width: 200,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              //     onPressed: isSendingOTP
              //         ? null
              //         : () async {
              //       String phoneNumber = phoneNumberController.text.trim();
              //
              //       // Validate the phone number and acceptance of terms
              //       if (_validatePhoneNumber(phoneNumber) && acceptTerms) {
              //         if (mounted) {
              //           setState(() {
              //             isSendingOTP = true;
              //           });
              //         }
              //
              //         // Send OTP
              //         String? generatedOtp = await sendOtp(phoneNumber);
              //
              //         if (mounted) {
              //           setState(() {
              //             isSendingOTP = false;
              //           });
              //         }
              //
              //         if (generatedOtp != null) {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => VerifyOtpScreen(generatedOtp, phoneNumber),
              //             ),
              //           );
              //         } else {
              //           CustomSnackBar.showSnackBar(title: 'Failed', message: 'Failed to send OTP',color: Colors.red);
              //         }
              //       } else {
              //         // Phone number or terms acceptance is not valid
              //         if (!_validatePhoneNumber(phoneNumber)) {
              //           CustomSnackBar.showSnackBar(title: 'Failed', message: 'Invalided mobile number',color: Colors.yellow);
              //         }
              //         if (!acceptTerms) {
              //           CustomSnackBar.showSnackBar(title: 'Failed', message: 'Accept Terms of Use and Privacy Policy',color: Colors.red);
              //         }
              //       }
              //     },
              //     child: isSendingOTP
              //         ? const CircularProgressIndicator(
              //       color: Colors.white,
              //     )
              //         : Text(
              //       'login'.tr,
              //       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validatePhoneNumber(String phoneNumber) {
    // Check if the phone number is 11 digits and starts with 01
    RegExp regex = RegExp(r'^01\d{9}$');
    return regex.hasMatch(phoneNumber);
  }

  Future<String?> sendOtp(String phoneNumber) async {
    // Replace these values with your actual API key, email ID, and sender ID
    String apiKey = '178438612649861920231205025339am5pks6rmx';
    String emailId = 'belalhoshan89@gmail.com';
    String senderId = '227';
    // API endpoint
    String apiUrl = 'https://24bulksms.com/24bulksms/api/otp-api-sms-send';

    // Message for OTP (you can customize this message)
    String otpMessage = 'Your OTP for Authentication is: ';

    // Generate a random 4-digit OTP
    String otp = _generateOtp();

    // Construct the message
    String message = '$otpMessage$otp';

    // Construct the data payload
    Map<String, String> data = {
      'api_key': apiKey,
      'sender_id': senderId,
      'message': message,
      'mobile_no': phoneNumber,
      'user_email': emailId,
    };

    // Send the OTP via SMS
    http.Response response = await http.post(Uri.parse(apiUrl), body: data);

    if (response.statusCode == 200) {
      CustomSnackBar.showSnackBar(title: 'Success', message: 'OTP sent successfully');
      Future.delayed(const Duration(seconds: 4), () =>CustomSnackBar.showSnackBar(title: otp, message: 'Developer mode OTP',color: AppColor.black, duration: const Duration(seconds: 10)));
      // You may want to store the OTP and other relevant data for verification
      print(otp);
      return otp;
      // Return the generated OTP
    } else {
      // Handle API call failure
      print('Failed to send OTP. Response code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // You may want to handle errors appropriately
      print(otp);
      return otp;
    }
  }

  String _generateOtp() {
    // return "1111";
    return ((1000 + DateTime.now().microsecondsSinceEpoch % 9000)).toString();
  }
}