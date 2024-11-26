import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/screen/home_screen.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';

import '../constant/text.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt selectIndex = 0.obs;
    List catList = [
      'All', 'News', 'Sports', 'Kids', 'Entertainment', 'Movie'
    ];
    return Scaffold(
      //backgroundColor: AppColor.black,
      appBar: customAppbar((){Get.off(const HomeScreen());}, 'Live Channels'),
      body: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //color: AppColor.purple.withOpacity(0.2)
          ),
          child: Center(
            child: ListView.builder(
                itemCount: catList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: (){
                        selectIndex.value = index;
                      },
                      child: Obx(
                            ()=> Container(
                              //margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: selectIndex.value == index ? AppColor.pink :AppColor.purple.withOpacity(0.2)
                          ),
                          child: Center(child: Text(catList[index],style: selectIndex.value == index ? AppTextStyle.white14w600 : AppTextStyle.purple14w600)),
                        ),
                      ),
                    ),
                  );
                }),
          ),

        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(left: 16,top: 20, right: 16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6,
              ),
              itemCount: 10,
              itemBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),

                  decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage('https://toffeelive.com/_next/image?url=https%3A%2F%2Fimages.toffeelive.com%2Fimages%2Fprogram%2F611%2Flogo%2F240x240%2Fmobile_logo_430542001673177743.png&w=128&q=75'),fit: BoxFit.cover)
                      ),
                    ),
                      10.verticalSpace,
                       SizedBox(
                        width: 100,
                        child: Text('Discovery Kids Channel',textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 3, style: AppTextStyle.purple14w500),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    ),
    );
  }
}
