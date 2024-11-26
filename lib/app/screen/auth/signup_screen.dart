import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/screen/auth/login_screen.dart';
import 'package:livetv2024/bcodez/app_controller.dart';

import '../../constant/color.dart';
import '../../constant/text.dart';
import '../../widgets/button.dart';
import '../../widgets/textfornfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AppController(),
        builder: (controller) {
          return Scaffold(
            //backgroundColor: AppColor.black,
            appBar: AppBar(
              backgroundColor: AppColor.white,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    50.verticalSpace,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/images/logo.png',
                            height: 24, width: 98)),
                    24.verticalSpace,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create an account.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.white20w600,
                      ),
                    ),
                    24.verticalSpace,
                    CustomTextField(
                      textController: controller.usernameController,
                      hintText: 'Enter Email',
                    ),
                    16.verticalSpace,
                    CustomTextField(
                      textController: controller.passwordController,
                      hintText: 'Enter Password',
                      obscureText: true,
                    ),
                    16.verticalSpace,
                    CustomTextField(
                      textController: controller.confPassController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),
                    24.verticalSpace,
                    CustomButton(
                      title: 'Signup',
                      //color: AppColor.teal,
                      gradient: AppColor.gradient,
                      onTap: () {},
                    ),
                    40.verticalSpace,
                    const Text(
                      "Already have an account ?",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.grey12w400
                    ),
                    12.verticalSpace,
                    CustomButton(
                      title: 'Login',
                      color: AppColor.white,
                      style: AppTextStyle.grey18w500,
                      border: Border.all(
                          color: AppColor.purple,
                          width: 1.0,
                          style: BorderStyle.solid),
                      onTap: () {
                        Get.off(const LoginScreen());
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
