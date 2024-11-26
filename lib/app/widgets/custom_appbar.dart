

import 'package:flutter/material.dart';
import 'package:livetv2024/app/constant/text.dart';

import '../constant/color.dart';

AppBar customAppbar(onTap, title) {
  return AppBar(
    elevation: 5,
    backgroundColor: AppColor.white,
    leading: InkWell(
        onTap: onTap,
        child: const Icon(Icons.arrow_back_ios_new,color: AppColor.pink,)),
    title: Text(
      title,
      style: AppTextStyle.purple16w500,
    ),
    centerTitle: true,
  );
}