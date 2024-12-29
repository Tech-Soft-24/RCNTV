import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';
import 'package:livetv2024/bcodez/app_controller.dart';
import 'package:video_player/video_player.dart';

import '../../constant/text.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key, required this.title, required this.url});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {

    if(url.startsWith("https://bldcmprod-cdn.toffeelive.com/")){

    }


    return GetBuilder(
        init: AppController(),
        builder: (controller){
      return Obx(
        ()=> Scaffold(
          backgroundColor: AppColor.black,
          appBar: controller.fullscreen.value ? null : customAppbar(() { Get.back(); }, title),
          body: SizedBox(
            width: Get.width,
            height: Get.height,
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: Get.width,
                height: controller.fullscreen.value ? Get.height*1.3 : Get.height,
                child: YoYoPlayer(
                    aspectRatio: controller.fullscreen.value ? MediaQuery.of(context).size.aspectRatio : 16 / 9,
                    url: url=='' ? "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8" : url,
                    autoPlayVideoAfterInit: true,
                    displayFullScreenAfterInit: false,
                    headers: url.startsWith("https://bldcmprod-cdn.toffeelive.com/") ? controller.headers[0] : url.startsWith("https://mprod-cdn.toffeelive.com/")? controller.headers[1] : url.startsWith("https://live-cdn.tsports.com/")? controller.headers[2] : null,
                    videoStyle:  const VideoStyle(
                      enableSystemOrientationsOverride: false,
                      qualityStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      progressIndicatorColors: VideoProgressColors(playedColor: AppColor.pink,bufferedColor: AppColor.grey,backgroundColor: AppColor.white),
                      forwardAndBackwardBtSize: 30.0,
                      playButtonIconSize: 40.0,
                      playIcon: Icon(
                        Icons.play_circle_outline,
                        size: 40.0, color: AppColor.grey,
                      ),
                      pauseIcon: Icon(
                        Icons.pause_circle_outline,
                        size: 40.0, color: AppColor.grey,
                      ),

                      //videoQualityPadding: EdgeInsets.all(5.0),
                    ),
                    videoLoadingStyle: const VideoLoadingStyle(
                      loading: Center(
                        child: Text("Loading video",style: AppTextStyle.purple14w600,),
                      ),
                    ),

                    allowCacheFile: true,
                    onFullScreen: (value) {
                      controller.fullscreen.value = value;
                      if (controller.fullscreen.value) {
                        // Hide the system navigation bar
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                      } else {
                        // Restore the system navigation bar
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                      }
                      print(MediaQuery.of(context).size.aspectRatio);
                    }
                ),
              ),
            ),
          ),
        ),
      );
    });

  }
}
