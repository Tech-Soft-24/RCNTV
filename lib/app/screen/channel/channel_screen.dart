import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/screen/channel/play_screen.dart';
import 'package:livetv2024/app/screen/home_screen.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';
import 'package:livetv2024/bcodez/app_controller.dart';

import '../../constant/text.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (controller) {
          List filterChannels = controller.channel
              .where((channel) =>
                  channel['cat'] ==
                  controller.catList[controller.selectedIndex.value]['cat'])
              .toList();

          return Scaffold(
            //backgroundColor: AppColor.black,
            appBar: customAppbar(() {
              Get.off(const HomeScreen());
            }, 'Live Channels'),
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
                        itemCount: controller.catList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                controller.selectedIndex.value = index;
                              },
                              child: Obx(
                                () => Container(
                                  //margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: controller.selectedIndex.value ==
                                              index
                                          ? AppColor.pink
                                          : AppColor.purple
                                              .withValues(alpha: 0.2)),
                                  child: Center(
                                      child: Text(
                                          controller.catList[index]['name'],
                                          style:
                                              controller.selectedIndex.value ==
                                                      index
                                                  ? AppTextStyle.white14w600
                                                  : AppTextStyle.purple14w600)),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.selectedIndex.value == 0,
                    child: Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.only(
                              left: 16, top: 20, right: 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: controller.channel.length,
                          itemBuilder: (_, index) {
                            var channels = controller.channel[index];

                            debugPrint(channels);
                            return InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Get.to(PlayScreen(
                                    title: channels['title'],
                                    url: channels['url']));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                    color:
                                        AppColor.black.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: AppColor.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(channels['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    10.verticalSpace,
                                    SizedBox(
                                      width: 100,
                                      child: Text(channels['title'],
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: AppTextStyle.purple14w500),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.selectedIndex.value != 0,
                    child: Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.only(
                              left: 16, top: 20, right: 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: filterChannels.length,
                          itemBuilder: (_, index) {
                            var channels = filterChannels[index];

                            debugPrint(channels);
                            return InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Get.to(PlayScreen(
                                    title: channels['title'],
                                    url: channels['url']));
                              },
                              splashColor: AppColor.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                    color: AppColor.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: AppColor.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(channels['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    10.verticalSpace,
                                    SizedBox(
                                      width: 100,
                                      child: Text(channels['title'],
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: AppTextStyle.purple14w500),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                //   Obx(
                // ()=> Visibility(
                //       visible: controller.selectedIndex.value==2,
                //       child: Expanded(
                //         child: GridView.builder(
                //             padding: const EdgeInsets.only(left: 16,top: 20, right: 16),
                //             physics: const BouncingScrollPhysics(),
                //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 3,
                //               mainAxisSpacing: 10,
                //               crossAxisSpacing: 10,
                //               childAspectRatio: 0.6,
                //             ),
                //             itemCount: sportsChannels.length,
                //             itemBuilder: (_, index) {
                //               var channels = sportsChannels[index];
                //
                //               print(channels);
                //               return InkWell(
                //                 borderRadius: BorderRadius.circular(8),
                //                 onTap: (){
                //                   Get.to(PlayScreen(title: channels['title'], url: channels['url']));
                //                 },
                //                 child: Container(
                //                   padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                //
                //                   decoration: BoxDecoration(
                //                       color: AppColor.black.withOpacity(0.1),
                //                       borderRadius: BorderRadius.circular(8)
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [Container(
                //                       height: 80,
                //                       width: 80,
                //                       decoration: BoxDecoration(
                //                           color: AppColor.white,
                //                           shape: BoxShape.circle,
                //                           image: DecorationImage(image: NetworkImage(channels['img']),fit: BoxFit.cover)
                //                       ),
                //                     ),
                //                       10.verticalSpace,
                //                       SizedBox(
                //                         width: 100,
                //                         child: Text(channels['title'],textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 3, style: AppTextStyle.purple14w500),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             }),
                //       ),
                //     ),
                //   ),
                //   Obx(
                // ()=> Visibility(
                //       visible: controller.selectedIndex.value==3,
                //       child: Expanded(
                //         child: GridView.builder(
                //             padding: const EdgeInsets.only(left: 16,top: 20, right: 16),
                //             physics: const BouncingScrollPhysics(),
                //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 3,
                //               mainAxisSpacing: 10,
                //               crossAxisSpacing: 10,
                //               childAspectRatio: 0.6,
                //             ),
                //             itemCount: kidsChannels.length,
                //             itemBuilder: (_, index) {
                //               var channels = kidsChannels[index];
                //
                //               print(channels);
                //               return InkWell(
                //                 borderRadius: BorderRadius.circular(8),
                //                 onTap: (){
                //                   Get.to(PlayScreen(title: channels['title'], url: channels['url']));
                //                 },
                //                 child: Container(
                //                   padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                //
                //                   decoration: BoxDecoration(
                //                       color: AppColor.black.withOpacity(0.1),
                //                       borderRadius: BorderRadius.circular(8)
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [Container(
                //                       height: 80,
                //                       width: 80,
                //                       decoration: BoxDecoration(
                //                           color: AppColor.white,
                //                           shape: BoxShape.circle,
                //                           image: DecorationImage(image: NetworkImage(channels['img']),fit: BoxFit.cover)
                //                       ),
                //                     ),
                //                       10.verticalSpace,
                //                       SizedBox(
                //                         width: 100,
                //                         child: Text(channels['title'],textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 3, style: AppTextStyle.purple14w500),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             }),
                //       ),
                //     ),
                //   ),
                //   Obx(
                // ()=> Visibility(
                //       visible: controller.selectedIndex.value==4,
                //       child: Expanded(
                //         child: GridView.builder(
                //             padding: const EdgeInsets.only(left: 16,top: 20, right: 16),
                //             physics: const BouncingScrollPhysics(),
                //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 3,
                //               mainAxisSpacing: 10,
                //               crossAxisSpacing: 10,
                //               childAspectRatio: 0.6,
                //             ),
                //             itemCount: entChannels.length,
                //             itemBuilder: (_, index) {
                //               var channels = entChannels[index];
                //
                //               print(channels);
                //               return InkWell(
                //                 borderRadius: BorderRadius.circular(8),
                //                 onTap: (){
                //                   Get.to(PlayScreen(title: channels['title'], url: channels['url']));
                //                 },
                //                 child: Container(
                //                   padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                //
                //                   decoration: BoxDecoration(
                //                       color: AppColor.black.withOpacity(0.1),
                //                       borderRadius: BorderRadius.circular(8)
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [Container(
                //                       height: 80,
                //                       width: 80,
                //                       decoration: BoxDecoration(
                //                           color: AppColor.white,
                //                           shape: BoxShape.circle,
                //                           image: DecorationImage(image: NetworkImage(channels['img']),fit: BoxFit.cover)
                //                       ),
                //                     ),
                //                       10.verticalSpace,
                //                       SizedBox(
                //                         width: 100,
                //                         child: Text(channels['title'],textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 3, style: AppTextStyle.purple14w500),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             }),
                //       ),
                //     ),
                //   ),
                //   Obx(
                // ()=> Visibility(
                //       visible: controller.selectedIndex.value==5,
                //       child: Expanded(
                //         child: GridView.builder(
                //             padding: const EdgeInsets.only(left: 16,top: 20, right: 16),
                //             physics: const BouncingScrollPhysics(),
                //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 3,
                //               mainAxisSpacing: 10,
                //               crossAxisSpacing: 10,
                //               childAspectRatio: 0.6,
                //             ),
                //             itemCount: movieChannels.length,
                //             itemBuilder: (_, index) {
                //               var channels = movieChannels[index];
                //
                //               print(channels);
                //               return InkWell(
                //                 borderRadius: BorderRadius.circular(8),
                //                 onTap: (){
                //                   Get.to(PlayScreen(title: channels['title'], url: channels['url']));
                //                 },
                //                 child: Container(
                //                   padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                //
                //                   decoration: BoxDecoration(
                //                       color: AppColor.black.withOpacity(0.1),
                //                       borderRadius: BorderRadius.circular(8)
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [Container(
                //                       height: 80,
                //                       width: 80,
                //                       decoration: BoxDecoration(
                //                           color: AppColor.white,
                //                           shape: BoxShape.circle,
                //                           image: DecorationImage(image: NetworkImage(channels['img']),fit: BoxFit.cover)
                //                       ),
                //                     ),
                //                       10.verticalSpace,
                //                       SizedBox(
                //                         width: 100,
                //                         child: Text(channels['title'],textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 3, style: AppTextStyle.purple14w500),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             }),
                //       ),
                //     ),
                //   ),
              ],
            ),
          );
        });
  }
}
