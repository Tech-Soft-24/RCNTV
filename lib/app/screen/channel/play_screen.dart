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
          body: YoYoPlayer(
              aspectRatio: 16 / 9,
              url: url=='' ? "https://bldcmprod-cdn.toffeelive.com/cdn/live/sony_sports_2_hd/playlist.m3u8" : url,
              autoPlayVideoAfterInit: true,
              displayFullScreenAfterInit: false,
              headers: {
                "Host": "bldcmprod-cdn.toffeelive.com",
                "cookie": "Edge-Cache-Cookie=URLPrefix=aHR0cHM6Ly9ibGRjbXByb2QtY2RuLnRvZmZlZWxpdmUuY29tLw:Expires=1733488466:KeyName=prod_linear:Signature=kjVLxtxugs6QShAH7gMmZx9-lhQbtANiJLtgwzKifRN8MtZAMOQul1tz1xHoG5mHVpwVzlq87X846wSiLdd6Bw",
                "user-agent": "Toffee (Linux;Android 14) AndroidXMedia3/1.1.1/64103898/4d2ec9b8c7534adc",
                "client-api-header": "angM1aXCHQLmmSW6cDlpXMD6tLdwnhMoUeaBBFKmd98bX6Vrae5xCMbm4gg0+u33rnxeGQDZNr2GD1tW0cWwKEpWimNlGqXVQGhpiIBz1JFxN+OxXcQqaMPrjwUhCyI5mO1DGyNv18+Z2EpmHtVnLzV9SrGsQWu4oRKjxE8QIMsRs6LrvL6hWGPlOGQke/qb5QxQZNetPzI39jHhX7Zi2XrCMIT4a+gk2Wu1c3wIybwkqknPcTp4Bj1cEF3Q+q1dV05SBhzpEDfoR2BLyQ6dV3LvmY6MNKxbUjby7hMsg35lFl2Df2mZsr7C27309w/qWi8lLXDjB7B1MozIGKn8rw3bXY5YlrPKBKztyiisAjQQi7kc5ISXyGSwRmhciwkciuitsSL0LlqHY7/Qkkh71EtaK3XEgVpLdH8zRCsTwfu1iIVPiDwTycuuBy4XWkcNnd0iLB35yftQpiL8HfpO2jQnrAwzePxszJ7mewVG+M0P/qyTBD52NkPR8uW0AZmDKp5LHTCGf7sqldDzpZvU+gsSdvtsBUcmHzjINGEoyXk=",
                "accept-encoding": "gzip"
              },
              videoStyle: const VideoStyle(
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
                print(controller.fullscreen.value);
              }
          ),
        ),
      );
    });

  }
}
