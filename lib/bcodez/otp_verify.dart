import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/screen/home_screen.dart';
import 'package:livetv2024/bcodez/app_controller.dart';
import 'package:pinput/pinput.dart';
import '../app/constant/color.dart';
import '../app/constant/text.dart';
import '../app/widgets/button.dart';
import '../app/widgets/snackbar.dart';
import '../app/widgets/textfornfield.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AppController(),
        builder: (controller){return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 20),
        child: Column(
          children: [
            80.verticalSpace,
            Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: 24, width: 98),
                    16.verticalSpace,
                    const Text('We’ve sent a verification code to your mobile. Enter it to complete the sign-up process.',style: AppTextStyle.grey20w600,),
                  ],
                )),
            84.verticalSpace,
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.purple,width: 1.0,strokeAlign: BorderSide.strokeAlignOutside)
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.purple,width: 1.0,strokeAlign: BorderSide.strokeAlignOutside)
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.purple,width: 1.0,strokeAlign: BorderSide.strokeAlignOutside)
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.purple,width: 1.0,strokeAlign: BorderSide.strokeAlignOutside)
                  ),
                ),
              ],
            ),

            */

            Pinput(
              controller: controller.pinController,
              focusNode: controller.focusNode,
              // androidSmsAutofillMethod: AndroidSmsAutofillMethod
              //     .smsUserConsentApi,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
              ),
              onCompleted: (pin) {
                controller.otpConfirm(pin: controller.pinController.text);
              },
            ),
            24.verticalSpace,
            CustomButton(
              title: 'Verify OTP',
              //color: AppColor.teal,
              gradient: AppColor.gradient,
              onTap: () {controller.otpConfirm(pin: controller.pinController.text);},
            ),
          ],
        ),
      )),
    );});
  }
}
