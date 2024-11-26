import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livetv2024/app/constant/color.dart';

import '../../widgets/custom_appbar.dart';

class YearlySub extends StatelessWidget {
  const YearlySub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: customAppbar((){Get.back();}, 'Yearly'),
    );
  }
}
