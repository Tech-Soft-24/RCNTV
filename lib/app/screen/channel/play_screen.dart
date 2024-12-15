import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';
import 'package:livetv2024/bcodez/app_controller.dart';
import 'package:video_player/video_player.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key, required this.title, required this.url});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {




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
              fit: BoxFit.contain,
              child: SizedBox(
                width: Get.width,
                height: Get.height,
                child: YoYoPlayer(
                    aspectRatio: controller.fullscreen.value ? MediaQuery.of(context).size.aspectRatio : 16 / 9,
                    url: url=='' ? "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8" : url,
                    autoPlayVideoAfterInit: true,
                    displayFullScreenAfterInit: false,
                    headers: controller.headers[0],
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
                        child: Text("Loading video"),
                      ),
                    ),

                    allowCacheFile: true,
                    onFullScreen: (value) {
                      controller.fullscreen.value = value;
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
