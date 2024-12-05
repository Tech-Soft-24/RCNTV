import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/text.dart';
import 'package:livetv2024/bcodez/otp_verify.dart';
import 'package:livetv2024/bcodez/app_controller.dart';

import '../app/constant/color.dart';
import '../app/widgets/button.dart';
import '../app/widgets/textfornfield.dart';

class OtpSignupScreen extends StatelessWidget {
  const OtpSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AppController(),
        builder: (controller){
      return Scaffold(
        body: SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
          child: Column(
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
                     const Text('Enter Your Mobile Number to Sign Up',style: AppTextStyle.grey20w600,),
                    ],
                  )),
              84.verticalSpace,
              CustomTextField(
                textController: controller.mobileotpController,
                hintText: 'Enter Mobile Number',
                obscureText: true,
              ),
              24.verticalSpace,
              CustomButton(
                title: 'Next',
                //color: AppColor.teal,
                gradient: AppColor.gradient,
                onTap: () {Get.to(const OtpVerifyScreen());},
              ),
            ],
          ),
        )),
      );
    });
  }
}
