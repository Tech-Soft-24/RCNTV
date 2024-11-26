import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';
import 'package:livetv2024/app/widgets/custom_appbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: customAppbar((){Get.back();},'Channel Category'),
      body: const Column(
        children: [

        ],
      ),
    );
  }
}
