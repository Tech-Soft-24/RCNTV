import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/text.dart';
import 'package:livetv2024/app/widgets/button.dart';
import 'package:livetv2024/bcodez/app_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/color.dart';
import '../widgets/home_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GetX(
        init: AppController(),
        builder: (controller){
          return Scaffold(
      //backgroundColor: AppColor.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        elevation: 5,
        title: Container(
          margin: const EdgeInsets.only(left: 10),
          height: 20,
          width: 81.57,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fill)),
        ),
        actions: [
          InkWell(
            onTap: (){showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    backgroundColor: AppColor.white,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20,bottom: 20),
                      height: 465,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: AppColor.white, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          CircleAvatar(radius: 35,backgroundColor: AppColor.pink,
                          backgroundImage: controller.users[0]['profile_img']=='' ? const NetworkImage('https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png') : NetworkImage('${controller.users[0]['profile_img']}'),
                          ),

                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: AppColor.grey,width: 1.0)),
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account : ${controller.users[0]['phoneNumber']}',
                                  softWrap: true,
                                  style: AppTextStyle.grey16w500,
                                ),
                                 10.verticalSpace,
                                 Text(
                                  'You are Enjoying ${controller.users[0]['package']} Tk Package',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: AppTextStyle.purple16w500,
                                ),
                              ],
                            ),
                          ),
                          50.verticalSpace,
                          const SizedBox(
                              width: 245,
                              child: Text(
                                'Are you sure you want to Logout?',
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: AppTextStyle.grey16w500,
                              )),

                          20.verticalSpace,
                          Container(
                            height: 50,
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: ElevatedButton(
                              onPressed: () async{
                                controller.logout();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.purple,
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100))),
                              child: const Text(
                                "Log Out",
                                style: AppTextStyle.white14w600,
                              ),
                            ),
                          ),
                          20.verticalSpace,
                          TextButton(
                              onPressed: () => Get.back(),
                              child: const Text(
                                "No I Don't",
                                style: AppTextStyle.purple14w600,
                              ))
                        ],
                      ),
                    ),
                  );
                });},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.purple, width: 0.5)),
              child: const Icon(
                Icons.person,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: controller.isLoading.value ==1 ? SingleChildScrollView(
          child: Column(
              children: [
                10.verticalSpace,
                Obx(
                    ()=> controller.paymentValue.value == 'pending'? Column(children: [
                      const Text('Click to Check your Payment',style: AppTextStyle.purple16w500,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
                        child: CustomButton(onTap: (){controller.userData(); Future.delayed(const Duration(seconds: 1), () =>controller.paymentCheck());}, title: 'Refresh',color: Colors.green,),
                      )
                                      ],) : controller.paymentValue.value == 'active' ? const SizedBox() :  Text('You are now Pro member until ${controller.formattedDate.value}',style: AppTextStyle.purple16w500,),
                ),
                10.verticalSpace,
                CarouselSlider(
                  items: controller.imageCarousal.map((image) => Builder(builder: (context) {
                    return Container(
                      height: 150.0,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: image["img-path"] == "" && image["img-path"].isEmpty ? BoxDecoration(
                        color: AppColor.purple,
                        border: Border.all(color: AppColor.purple,style: BorderStyle.solid,width: 1.0),
                        borderRadius: BorderRadius.circular(
                            16),
                      ) : BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image["img-path"]),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(color: AppColor.purple,style: BorderStyle.solid,width: 1.0),
                        borderRadius: BorderRadius.circular(
                            16), // Adjust the radius as needed
                      ),
                    );
                  }))
                      .toList(),
                  options: CarouselOptions(
                      height: 145.0,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      initialPage: controller.currentIndex.value,
                      onPageChanged: (index, reason) {
                        controller.currentIndex.value = index;
                      },
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800)

                  ),
                  carouselController: controller.carouselSliderController,
                ),
                12.verticalSpace,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    controller.imageCarousal.asMap().entries.map((entry) {

                      return InkWell(
                          onTap: () {
                            // Handle image tap event (consider navigation or action based on index)
                            debugPrint("Image at index ${controller.currentIndex.value} tapped!"); // Or perform desired action
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 3, right: 3),
                            width: controller.currentIndex == entry.key ? 8 : 8,
                            // Adjust width as needed
                            height: 8.0,
                            // Adjust height as needed
                            decoration: BoxDecoration(
                              color: controller.currentIndex == entry.key
                                  ? AppColor.purple
                                  : AppColor.pink,
                              borderRadius: BorderRadius.circular(
                                  50.0), // Adjust corner radius
                            ),
                          ));
                    }).toList(), // Convert the map entries to a list for the Row's children
                  ),
                ),

                24.verticalSpace,
                HomeContainer(
                  onTap: () {
                    controller.subscribe();
                    //Get.to(const SubscribePage());
                    //  Get.to(const ChannelScreen());
                  },
                  title: 'Live TV',
                  subtitle: '400+ channel',
                  gradient: AppColor.gradient,
                ),
                16.verticalSpace,
                HomeContainer(
                  onTap: () {controller.openUrl(url: controller.homeLinks[0]['rcnTv']);
                    debugPrint(controller.homeLinks[0]['rcnTv']);
                    },
                  title: 'RCN TV',
                  gradient: AppColor.gradient,
                ),
                16.verticalSpace,
                HomeContainer(
                  onTap: () {controller.openUrl(url: controller.homeLinks[0]['rcnipTv']);},
                  title: 'RCN IP TV',
                  gradient: AppColor.gradient,
                ),
                16.verticalSpace,
                HomeContainer(
                  onTap: () {controller.openUrl(url: controller.homeLinks[0]['rcntvLive']);},
                  title: 'RCN TV Live',
                  gradient: AppColor.gradient,
                ),
                16.verticalSpace,
                HomeContainer(
                  onTap: () {launchUrl(Uri.parse('${controller.homeLinks[0]['rcnWebsite']}'), mode: LaunchMode.platformDefault);},
                  title: 'RCN Website',
                  gradient: AppColor.gradient,
                ),
              ],
            ),
        ) : const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: CircularProgressIndicator(color: AppColor.pink,))],)

    );});
  }
}
