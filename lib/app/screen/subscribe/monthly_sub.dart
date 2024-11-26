import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/constant/text.dart';
import 'package:livetv2024/app/screen/payment/payment_page.dart';
import 'package:livetv2024/app/widgets/button.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';

class MonthYearSub extends StatelessWidget {
  const MonthYearSub({super.key, this.title, this.price});

  final String? title;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColor.black,
      appBar: customAppbar((){Get.back();}, title?? 'Monthly'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.verticalSpace,
            Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/images/logo.png', height: 24, width: 98)),
            24.verticalSpace,
             Text('Unlock All Channels',style: AppTextStyle.grey32w500),
            Divider(
              color: AppColor.black.withOpacity(0.2),
              thickness: 1.0,
              height: 32,
            ),

             Text('PLAN',style: AppTextStyle.grey16w500),
            8.verticalSpace,
            Text('$title Subscription',style: AppTextStyle.grey20w700),
            Divider(
              color: AppColor.black.withOpacity(0.2),
              thickness: 1.0,
              height: 32,
            ),
            Text('PRICE',style: AppTextStyle.grey16w500) ,
            8.verticalSpace,
            Text(price ??'200 TK / Month',style: AppTextStyle.grey20w700),
            Divider(
              color: AppColor.black.withOpacity(0.2),
              thickness: 1.0,
              height: 32,
            ),
            CustomButton(onTap: (){Get.off(const PaymentPage());}, title: 'Continue to Payment', gradient: AppColor.gradient,)
          ],
        ),
      ),
    );
  }
}
