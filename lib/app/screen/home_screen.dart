import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livetv2024/bcodez/app_controller.dart';
import '../constant/color.dart';
import '../widgets/home_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller){return Scaffold(
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
          Container(
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
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
              ()=> Column(
            children: [
              20.verticalSpace,
              Container(
                child: CarouselSlider(
                  items: controller.imageCarousal.map((image) => Builder(builder: (context) {
                    return Container(
                      height: 130.0,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: image["img-path"] == "" && image["img-path"].isEmpty ? BoxDecoration(
                        color: AppColor.purple,
                        borderRadius: BorderRadius.circular(
                            16),
                      ) : BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image["img-path"]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(
                            16), // Adjust the radius as needed
                      ),
                    );
                  }))
                      .toList(),
                  options: CarouselOptions(
                      height: 125.0,
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
                          print("Image at index ${controller.currentIndex.value} tapped!"); // Or perform desired action
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
                subtitle: '300+ channel',
                gradient: AppColor.gradient,
              ),
              16.verticalSpace,
              HomeContainer(
                onTap: () {},
                title: 'RCN TV',
                gradient: AppColor.gradient,
              ),
              16.verticalSpace,
              HomeContainer(
                onTap: () {},
                title: 'RCN IP TV',
                gradient: AppColor.gradient,
              ),
              16.verticalSpace,
              HomeContainer(
                onTap: () {},
                title: 'RCN TV Live',
                gradient: AppColor.gradient,
              ),
              16.verticalSpace,
              HomeContainer(
                onTap: () {},
                title: 'RCN Website',
                gradient: AppColor.gradient,
              ),
            ],
          ),
        ),
      ),
    );});
  }
}
