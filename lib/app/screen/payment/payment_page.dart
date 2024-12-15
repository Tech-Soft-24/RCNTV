import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/widgets/button.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';
import 'package:livetv2024/app/widgets/snackbar.dart';
import 'package:livetv2024/bcodez/app_controller.dart';

import '../../constant/color.dart';
import '../../constant/text.dart';
import '../../widgets/textfornfield.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.price});

  final String? price;

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
                    20.verticalSpace,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('পেমেন্ট নির্দেশাবলী',style: TextStyle(
                          color: AppColor.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 24),),
                    ),
                    Divider(height: 20,color: AppColor.grey.withOpacity(0.5),thickness: 1.0,),
                    SizedBox(
                    //  padding: EdgeInsets.symmetric(horizontal: 20),
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('১. পেমেন্ট পদ্ধতি : ',style: AppTextStyle.grey18w500,),
                          Text('পেমেন্ট করতে প্রথমে ( ${controller.paymentOption[controller.selectIndex.value]['payNum']} ) এই নম্বরে সেন্ড মানি করুন। (যেমন বিকাশ, নগদ, রকেট ইত্যাদি)', style: AppTextStyle.grey16w500,),
                          10.verticalSpace,
                          const Text('২. ফর্মটি পূরণ করুন ',style: AppTextStyle.grey18w500,),
                          const Text('আপনার পেমেন্ট সম্পন্ন হলে,যে নম্বর থেকে পেমেন্ট করেছেন, সেই নম্বরটি লিখুন।', style: AppTextStyle.grey16w500,),
                          const Text('আপনি যে ট্রানজেকশন আইডি পেয়েছেন, সেটি লিখুন।', style: AppTextStyle.grey16w500,),
                          const Text('"পেমেন্ট অপশন" ড্রপডাউন মেনু থেকে আপনার পেমেন্ট পদ্ধতি (যেমন বিকাশ, নগদ, রকেট ইত্যাদি) নির্বাচন করুন।', style: AppTextStyle.grey16w500,),
                          10.verticalSpace,
                          const Text('৩. পেমেন্ট নিশ্চিত করুন',style: AppTextStyle.grey18w500,),
                          const Text('ফর্মটি সঠিকভাবে পূরণ করার পরে "পে নাউ" (Pay Now) বোতামে ক্লিক করুন।', style: AppTextStyle.grey16w500,),
                          Divider(height: 30,color: AppColor.grey.withOpacity(0.5),thickness: 1.0,),
                          const Text('সঠিক তথ্য প্রদান করা হলে, আপনার পেমেন্ট নিশ্চিত হবে এবং আপনার প্যাকেজটি সক্রিয় করা হবে।',textAlign: TextAlign.center, style: AppTextStyle.grey16w500,),
                           Text('যদি আপনার কোনো সমস্যা হয়, অনুগ্রহ করে আমাদের সহায়তা (${controller.paymentOption[controller.selectIndex.value]['helpNum']}) কেন্দ্রের সাথে যোগাযোগ করুন।',textAlign: TextAlign.center, style: AppTextStyle.grey16w500,),



                        ],
                      ),
                    ),
                    30.verticalSpace,
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
                    16.verticalSpace,
                    CustomTextField(
                      textController: controller.transactionController,
                      hintText: 'Transaction ID',
                    ),
                    16.verticalSpace,
                    CustomTextField(
                      textController: controller.amountController..text=price!,
                      hintText: 'Amount',
                    ),


                    24.verticalSpace,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                          onTap: () {
                            int endTime;
                           if(controller.mobileController.text.isEmpty || controller.amountController.text.isEmpty || controller.transactionController.text.isEmpty || controller.selectedLang.value ==''){
                             CustomSnackBar.showSnackBar(title: 'Error', message: "Box shouldn't be empty",color: Colors.red);
                           } else{
                             if(price=='200'){
                                endTime = 30;
                             } else {
                                endTime = 365;
                             }
                            controller.paymentOk(payMob: controller.mobileController.text, payId: controller.transactionController.text, package: controller.amountController.text, endTime : endTime, payBy: controller.selectedLang.value);
                          }
                          //Get.off(const ChannelScreen());
                          },
                          title: 'Pay Now',
                          gradient: AppColor.gradient,),
                    ),
                    100.verticalSpace
                  ],
                ),
              ),
            ),
          );
        });
  }
}
