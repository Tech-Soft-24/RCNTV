import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/widgets/button.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';
import 'package:livetv2024/bcodez/app_controller.dart';

import '../../constant/color.dart';
import '../../constant/text.dart';
import '../../widgets/textfornfield.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AppController(),
        builder: (controller) {
          return Scaffold(
           // backgroundColor: AppColor.black,
            appBar: customAppbar(() {
              Get.back();
            }, 'Payment Page'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    80.verticalSpace,
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select Payment Method',
                          style: TextStyle(
                              color: AppColor.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 24),
                        )),
                    Divider(
                      color: AppColor.black.withOpacity(0.2),
                      thickness: 1.0,
                      height: 32,
                    ),
                    CustomTextField(
                      textController: controller.mobileController,
                      hintText: 'Mobile Number',
                    ),
                    16.verticalSpace,
                    CustomTextField(
                      textController: controller.amountController,
                      hintText: 'Amount',
                    ),
                    16.verticalSpace,
                    CustomTextField(
                      textController: controller.transactionController,
                      hintText: 'Transaction ID',
                    ),
                    16.verticalSpace,
                    Container(
                      height: ScreenUtil().setHeight(52),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.purple, width: 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton<String>(
                            hint: const Text(
                              'Payment Options',
                              style: AppTextStyle.grey18w500
                            ),
                            // menuWidth: Get.width - 40,
                            dropdownColor: AppColor.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(25),
                            value: controller.selectedLang.value.isEmpty
                                ? null
                                : controller.selectedLang.value,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColor.purple,
                              size: 44,
                            ),
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              controller.selectedLang.value = newValue!;
                            },
                            items: controller.payment
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      color: AppColor.purple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    CustomButton(
                        onTap: () {
                          controller.paymentOk();
                          //Get.off(const ChannelScreen());
                        },
                        title: 'Pay Now',
                        gradient: AppColor.gradient,)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
