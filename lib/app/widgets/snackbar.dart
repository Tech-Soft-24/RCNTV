import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';

class CustomSnackBar {
  static showSnackBar({required String title, required String message, Color? color, Duration? duration}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: AppColor.white,
      backgroundColor: color ?? Colors.green,
      icon: const Icon(
        Icons.phone_android_outlined,
        color: AppColor.white,
      ),
    );
  }
}