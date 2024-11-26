import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/screen/auth/signup_screen.dart';
import 'package:livetv2024/bcodez/app_controller.dart';

import '../../constant/text.dart';
import '../../widgets/button.dart';
import '../../widgets/textfornfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
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
                     const Text(
                      'To continue with your subscription, please log in or create an account.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextStyle.grey20w600),
                    24.verticalSpace,
                     CustomTextField(
                      textController: controller.emailController,
                      hintText: 'Enter Email',
                    ),
                    16.verticalSpace,
                     CustomTextField(
                       textController: controller.passwordController,
                      hintText: 'Enter Password',
                      obscureText: true,
                    ),
                    24.verticalSpace,
                    CustomButton(
                      title: 'Login',
                     // color: AppColor.purple,
                      gradient: AppColor.gradient,
                      onTap: () {
                        controller.login(controller.emailController.text, controller.passwordController.text);
                      //  Get.offAll(const HomeScreen());
                      },
                    ),
                    40.verticalSpace,
                    const Text(
                      "Don't have an account ?",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.grey12w400
                    ),
                    12.verticalSpace,
                    CustomButton(
                      title: 'Signup',
                      style: AppTextStyle.grey18w500,
                      color: AppColor.white,
                      border: Border.all(
                          color: AppColor.purple,
                          width: 1.0,
                          style: BorderStyle.solid),
                      onTap: () {
                        Get.off(const SignupScreen());
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
