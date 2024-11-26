import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/color.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    super.key, required this.onTap, this.gradient, this.color, this.title, this.subtitle
  });

  final  Function()? onTap;
  final Gradient? gradient;
  final Color? color;
  final String ? title;
  final String ? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColor.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Ink(
        width: Get.width-40,
        //margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  title ?? ' ',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white),
                ),
                2.verticalSpace,
                subtitle!=null? Text(
                  subtitle?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ) : const SizedBox()
              ],
            ),
            Image.asset(
              'assets/images/arrow-right.png',
              height: 28,
              width: 28,
            )
          ],
        ),
      ),
    );
  }
}