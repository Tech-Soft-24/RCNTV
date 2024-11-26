import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/controller/splash_controller.dart';

import '../constant/text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller){
      return Scaffold(
      //backgroundColor: AppColor.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 103),
            child: Image.asset('assets/images/logo.png'),
          ),
          80.verticalSpace,
           const Text('Welcome', textAlign: TextAlign.center, style: AppTextStyle.grey40w500),
          8.verticalSpace,
           const Text('Watch Live TV Anytime,\n Anywhere!',textAlign: TextAlign.center,style: AppTextStyle.grey20w600),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('BasakCodez',style: TextStyle(color: AppColor.white.withOpacity(0.2),fontSize: 16),),
          ),
          30.verticalSpace
        ],
      ),
    );});
  }
}
