import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/screen/subscribe/monthly_sub.dart';
import 'package:livetv2024/app/widgets/button.dart';
import 'package:livetv2024/bcodez/app_controller.dart';

import '../../constant/text.dart';
import '../../widgets/custom_appbar.dart';

class SubscribePage extends StatelessWidget {
  const SubscribePage({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller){
      return Scaffold(
        //backgroundColor: AppColor.black,
        appBar: customAppbar((){Get.back();}, 'Package'),
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
              Container(
                padding: const EdgeInsets.all(5),
              //  margin: const EdgeInsets.symmetric(horizontal: 91),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.purple.withValues(alpha: 0.2)
                ),
                child: ListView.builder(
                    itemCount: controller.paymentOption.length,
                    scrollDirection: Axis.horizontal,
                  //  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_,index){
                      return Obx(
                          ()=> InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: (){
                            controller.selectIndex.value = index;
                            if(controller.selectIndex.value==1){
                              controller.monthSelect.value = false;
                            } else {
                              controller.monthSelect.value = true;
                            }
                          },
                          child: Container(
                            //  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: controller.selectIndex.value == index ? AppColor.pink :Colors.transparent
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: Center(child: Text(controller.subscribeList[index],style: const TextStyle(color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w600),)),
                              ),
                            ),

                        ),
                      );
                    }),

              ),
              24.verticalSpace,
              const Text('Unlock All Channels',style: AppTextStyle.grey32w500),
              Divider(
                color: AppColor.black.withOpacity(0.2),
                thickness: 1.0,
                height: 32,
              ),
              //Obx(()=> Text(controller.monthSelect.value == true? '${controller.paymentOption[0]['package']}' : '${controller.paymentOption[1]['package']}',style: AppTextStyle.grey20w700,)),
              Obx(()=> Text('${controller.paymentOption[controller.selectIndex.value]['package']}',style: AppTextStyle.grey20w700,)),
              8.verticalSpace,
              const Text('Unlimited Access to Premium Content',style: AppTextStyle.grey14w500,),
              Divider(
                color: AppColor.black.withOpacity(0.2),
                thickness: 1.0,
                height: 32,
              ),
               const Text('✓ 300+ Live Channels',style: AppTextStyle.grey16w500),
               const Text('✓ HD Streaming',style: AppTextStyle.grey16w500),
               const Text('✓ Ad-Free Experience',style:  AppTextStyle.grey16w500),
               const Text('✓ Exclusive Content',style:  AppTextStyle.grey16w500),
               const Text('✓ Cancel Anytime',style:  AppTextStyle.grey16w500),
              24.verticalSpace,
              CustomButton(onTap: (){

                  Get.to( MonthYearSub(title: '${controller.paymentOption[controller.selectIndex.value]['planText']}', price: '${controller.paymentOption[controller.selectIndex.value]['tk']}'));


              }, title: 'Subscribe Now', gradient: AppColor.gradient,)

            ],
          ),
        ),
      );
    });
  }
}
