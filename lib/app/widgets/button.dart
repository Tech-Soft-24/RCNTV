
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/text.dart';

import '../constant/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.onTap, this.gradient, required this.title, this.color, this.style, this.border
  });
  final  Function()? onTap;
  final String? title;
  final Color? color;
  final TextStyle? style;
  final BoxBorder? border;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColor.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 14),
        width: Get.width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
            border: border,
            gradient: gradient

        ),
        child: Center(
          child: Text(title?? " ",
            style: style ?? AppTextStyle.white18w500),
        ),
      ),
    );
  }
}